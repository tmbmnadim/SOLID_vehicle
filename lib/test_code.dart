// // Domain Layer - Entities
// class Product {
//   final String id;
//   final String name;
//   final double price;

//   const Product({
//     required this.id,
//     required this.name,
//     required this.price,
//   });
// }

// class CartItem {
//   final Product product;
//   final int quantity;

//   const CartItem({
//     required this.product,
//     required this.quantity,
//   });

//   double get total => product.price * quantity;
// }

// class Cart {
//   final List<CartItem> items;

//   const Cart({required this.items});

//   double get totalAmount =>
//       items.fold(0.0, (double sum, CartItem item) => sum + item.total);
// }

// // Domain Layer - Repository Interfaces
// abstract class ICartRepository {
//   Future<Cart> getCart();
//   Future<void> addItem(String productId, int quantity);
// }

// abstract class IProductRepository {
//   Future<Product> getProduct(String id);
// }

// // Domain Layer - UseCases
// class AddToCartUseCase {
//   final ICartRepository cartRepository;
//   final IProductRepository productRepository;

//   const AddToCartUseCase({
//     required this.cartRepository,
//     required this.productRepository,
//   });

//   Future<void> execute(String productId, int quantity) async {
//     final Product product = await productRepository.getProduct(productId);
//     await cartRepository.addItem(productId, quantity);
//   }
// }

// // Data Layer - Models
// class CartDTO {
//   final String id;
//   final List<CartItemDTO> items;

//   const CartDTO({
//     required this.id,
//     required this.items,
//   });
// }

// class CartItemDTO {
//   final String productId;
//   final int quantity;

//   const CartItemDTO({
//     required this.productId,
//     required this.quantity,
//   });
// }

// // Data Layer - Repositories
// class CartRepository implements ICartRepository {
//   final CartDataSource dataSource;
//   final ProductRepository productRepository;

//   const CartRepository({
//     required this.dataSource,
//     required this.productRepository,
//   });

//   @override
//   Future<Cart> getCart() async {
//     final CartDTO cartDTO = await dataSource.getCart();
//     final List<CartItem> items =
//         await Future.wait(cartDTO.items.map((CartItemDTO item) async {
//       final Product product =
//           await productRepository.getProduct(item.productId);
//       return CartItem(
//         product: product,
//         quantity: item.quantity,
//       );
//     }));
//     return Cart(items: items);
//   }

//   @override
//   Future<void> addItem(String productId, int quantity) async {
//     await dataSource.addItem(productId, quantity);
//   }
// }

// // Presentation Layer - States and Events
// abstract class CartState {}

// class CartInitial extends CartState {}

// class CartLoading extends CartState {}

// class CartLoaded extends CartState {
//   final Cart cart;
//   const CartLoaded(this.cart);
// }

// class CartError extends CartState {
//   final String message;
//   const CartError(this.message);
// }

// abstract class CartEvent {}

// class AddToCart extends CartEvent {
//   final String productId;
//   final int quantity;

//   const AddToCart({
//     required this.productId,
//     required this.quantity,
//   });
// }

// // Presentation Layer - BLoC
// class CartBloc extends Bloc<CartEvent, CartState> {
//   final AddToCartUseCase addToCartUseCase;
//   final GetCartUseCase getCartUseCase;

//   CartBloc({
//     required this.addToCartUseCase,
//     required this.getCartUseCase,
//   }) : super(CartInitial()) {
//     on<AddToCart>((AddToCart event, Emitter<CartState> emit) async {
//       emit(CartLoading());
//       try {
//         await addToCartUseCase.execute(
//           event.productId,
//           event.quantity,
//         );
//         final Cart cart = await getCartUseCase.execute();
//         emit(CartLoaded(cart));
//       } catch (e) {
//         emit(CartError(e.toString()));
//       }
//     });
//   }
// }

// // Dependency Injection
// class DependencyInjection {
//   static void init() {
//     // Data Sources
//     final ProductDataSource productDataSource = ProductDataSource();
//     final CartDataSource cartDataSource = CartDataSource();

//     // Repositories
//     final ProductRepository productRepository =
//         ProductRepository(productDataSource);
//     final CartRepository cartRepository = CartRepository(
//       dataSource: cartDataSource,
//       productRepository: productRepository,
//     );

//     // Use Cases
//     final AddToCartUseCase addToCartUseCase = AddToCartUseCase(
//       cartRepository: cartRepository,
//       productRepository: productRepository,
//     );
//     final GetCartUseCase getCartUseCase = GetCartUseCase(
//       cartRepository: cartRepository,
//     );

//     // BLoCs
//     final CartBloc cartBloc = CartBloc(
//       addToCartUseCase: addToCartUseCase,
//       getCartUseCase: getCartUseCase,
//     );

//     // Register with GetIt
//     GetIt.I.registerSingleton<CartBloc>(cartBloc);
//   }
// }

// // UI Layer
// class ProductDetailScreen extends StatelessWidget {
//   const ProductDetailScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<CartBloc>(
//       create: (BuildContext context) => GetIt.I<CartBloc>(),
//       child: BlocBuilder<CartBloc, CartState>(
//         builder: (BuildContext context, CartState state) {
//           return ElevatedButton(
//             onPressed: () {
//               context.read<CartBloc>().add(
//                     const AddToCart(
//                       productId: '123',
//                       quantity: 1,
//                     ),
//                   );
//             },
//             child: const Text('Add to Cart'),
//           );
//         },
//       ),
//     );
//   }
// }
