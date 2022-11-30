package no.shoppifly;

import io.micrometer.core.annotation.Timed;
import io.micrometer.core.instrument.Gauge;
import io.micrometer.core.instrument.MeterRegistry;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController()
public class ShoppingCartController implements ApplicationListener<ApplicationReadyEvent> {


    private Map<String, Float> cartSum = new HashMap();

    @Autowired
    private final CartService cartService;

    private MeterRegistry meterRegistry;

    @Autowired
    public ShoppingCartController(CartService cartService, MeterRegistry meterRegistry){
        this.cartService = cartService;
        this.meterRegistry = meterRegistry;
    }

    @GetMapping(path = "/cart/{id}")
    public Cart getCart(@PathVariable String id) {
        return cartService.getCart(id);
    }

    /**
     * Checks out a shopping cart. Removes the cart, and returns an order ID
     *
     * @return an order ID
     */
    @Timed
    @PostMapping(path = "/cart/checkout")
    public String checkout(@RequestBody Cart cart) {
        meterRegistry.counter("checkouts").increment();
        String cartId = cart.getId();
        cartService.checkout(cart);
        cartSum.remove(cartId);
        return cartId;
    }

    /**
     * Updates a shopping cart, replacing it's contents if it already exists. If no cart exists (id is null)
     * a new cart is created.
     *
     * @return the updated cart
     */
    @PostMapping(path = "/cart")
    public Cart updateCart(@RequestBody Cart cart) {

        // remove cart from cartSum if it exists
        if (cartSum.containsKey(cart.getId())) {
            cartSum.remove(cart.getId());
        }

        // add cart and item total value to cartSum
        cart.getItems().forEach(item -> {
            if (cartSum.containsKey(cart.getId())) {
                cartSum.put(cart.getId(), cartSum.get(cart.getId()) + item.getUnitPrice());
            } else {
                cartSum.put(cart.getId(), item.getUnitPrice());
            }
        });

        return cartService.update(cart);
    }

    /**
     * return all cart IDs
     *
     * @return
     */
    @GetMapping(path = "/carts")
    public List<String> getAllCarts() {
        return cartService.getAllsCarts();
    }


    @Override
    public void onApplicationEvent(ApplicationReadyEvent applicationReadyEvent) {
        // value of total carts
        Gauge.builder("carts", cartSum,
                b -> b.values().size()).register(meterRegistry);

        // Denne meter-typen "Gauge" rapporterer hvor mye penger som totalt
        // finnes i cartsene xp
        Gauge.builder("cartvalue", cartSum,
                        b -> b.values().stream()
                                .mapToDouble(Float::doubleValue)
                                .sum())
                .register(meterRegistry);
    }
}
