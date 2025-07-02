import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/zaytooon_theme.dart';
import '../providers/cart_provider.dart';

final List<Map<String, dynamic>> meals = [
  {
    "name": "برجر دجاج",
    "img": "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.almarai.com%2Far%2Frecipes%2Fchicken-burger-with-avocado-sauce&psig=AOvVaw2mkazrZCJ9RDlaJOwEAY4G&ust=1751575364153000&source=images&cd=vfe&opi=89978449&ved=0CBUQjRxqFwoTCKjJqp2Fn44DFQAAAAAdAAAAABAE",
    "price": 2.000,
    "desc": "برجر دجاج طازج مع صوص خاص وخس.",
    "category": "وجبات",
  },
  {
    "name": "بيتزا مارجريتا",
    "img": "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.puckarabia.com%2Far%2Frecipes%2Fmargherita-pizza-with-cauliflower-crust%2F&psig=AOvVaw2n-2p-UvK604zvs-NNjWCe&ust=1751575211996000&source=images&cd=vfe&opi=89978449&ved=0CBUQjRxqFwoTCNic9aaEn44DFQAAAAAdAAAAABAE",
    "price": 7.000,
    "desc": "بيتزا إيطالية بالجبن والطماطم الطازجة.",
    "category": "وجبات",
  },
  {
    "name": "عصير برتقال طازج",
    "img": "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.carrefourksa.com%2Fmafsau%2Far%2Fconcentrate-fruit-juice%2Foriginal-orange-carrot-1-4l%2Fp%2F53254&psig=AOvVaw220Iz_YoyVFOCmIu1PDYLa&ust=1751575118901000&source=images&cd=vfe&opi=89978449&ved=0CBUQjRxqFwoTCNCN7vyDn44DFQAAAAAdAAAAABAE",
    "price": 1.500,
    "desc": "عصير برتقال طبيعي ومنعش.",
    "category": "مشروبات",
  },
    {
    "name": "بقلاوة",
    "img": "https://www.google.com/url?sa=i&url=https%3A%2F%2Fistanbulsaray.com%2Far%2F%25D8%25A7%25D9%2584%25D8%25AD%25D9%2584%25D9%2588%25D9%258A%25D8%25A7%25D8%25AA-%25D8%25A7%25D9%2584%25D8%25AA%25D8%25B1%25D9%2583%25D9%258A%25D8%25A9%2F%25D8%25A7%25D9%2584%25D8%25A8%25D9%2582%25D9%2584%25D8%25A7%25D9%2588%25D8%25A9-%25D8%25A7%25D9%2584%25D8%25AA%25D8%25B1%25D9%2583%25D9%258A%25D8%25A9%2F%25D8%25A8%25D9%2582%25D9%2584%25D8%25A7%25D9%2588%25D8%25A9-%25D8%25AA%25D8%25B1%25D9%2583%25D9%258A%25D8%25A9-%25D8%25A8%25D8%25A7%25D9%2584%25D9%2581%25D8%25B3%25D8%25AA%25D9%2582-%25D9%2585%25D9%2586-%25D8%25AD%25D9%2584%25D9%2588%25D9%258A%25D8%25A7%25D8%25AA-%25D8%25AD%25D8%25A7%25D9%2581%25D8%25B8-%25D9%2585%25D8%25B5%25D8%25B7%25D9%2581%25D9%2589%2F2&psig=AOvVaw0yJqL9G7ODpDDQ6jPm2a2q&ust=1751575018954000&source=images&cd=vfe&opi=89978449&ved=0CBUQjRxqFwoTCKjy1MiDn44DFQAAAAAdAAAAABAE",
    "price": 6.000,
    "desc": "بقلاة شهية مغرقه بالسمن البلدي.",
    "category": "حلويات",
  },
    {
    "name": "عصير مانجو",
    "img": "https://www.google.com/url?sa=i&url=https%3A%2F%2Faltibbi.com%2F%25D9%2585%25D9%2582%25D8%25A7%25D9%2584%25D8%25A7%25D8%25AA-%25D8%25B7%25D8%25A8%25D9%258A%25D8%25A9%2F%25D8%25AA%25D8%25BA%25D8%25B0%25D9%258A%25D8%25A9%2F%25D9%2581%25D9%2588%25D8%25A7%25D8%25A6%25D8%25AF-%25D8%25B9%25D8%25B5%25D9%258A%25D8%25B1-%25D8%25A7%25D9%2584%25D9%2585%25D8%25A7%25D9%2586%25D8%25AC%25D9%2588-6228&psig=AOvVaw34J-wELfbg679537LZL_u9&ust=1751575070381000&source=images&cd=vfe&opi=89978449&ved=0CBUQjRxqFwoTCOCOsuGDn44DFQAAAAAdAAAAABAE",
    "price": 1.500,
    "desc": "عصير مانو مع سكر خفيف طبيعي ومنعش.",
    "category": "مشروبات",
  },
    {
    "name": "طلب فول",
    "img": "https://www.google.com/url?sa=i&url=https%3A%2F%2Fmawdoo3.com%2F%25D8%25B7%25D8%25B1%25D9%258A%25D9%2582%25D8%25A9_%25D8%25B9%25D9%2585%25D9%2584_%25D8%25B7%25D8%25A8%25D9%2582_%25D9%2581%25D9%2588%25D9%2584&psig=AOvVaw3vngT48AUOa5drVPU3VCjf&ust=1751574965143000&source=images&cd=vfe&opi=89978449&ved=0CBUQjRxqFwoTCJDBta-Dn44DFQAAAAAdAAAAABAE",
    "price": 1.500,
    "desc": "فول سيوبر حبه كبيره عالي الجودة مع قشره خفيفه.",
    "category": "وجبات",
  },

];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: ZaytooonTheme.background,
      appBar: AppBar(
        title: const Text('زيتون'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      floatingActionButton: Stack(
        alignment: Alignment.topLeft,
        children: [
          FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, '/cart'),
            tooltip: 'السلة',
            child: const Icon(Icons.shopping_cart),
          ),
          if (cartProvider.items.isNotEmpty)
            Positioned(
              left: 0,
              top: 0,
              child: CircleAvatar(
                backgroundColor: Colors.red,
                radius: 12,
                child: Text(
                  '${cartProvider.items.length}',
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            "اقتراحات الوجبات",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: ZaytooonTheme.primary,
            ),
          ),
          const SizedBox(height: 12),
          ...meals.map((meal) => Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                elevation: 4,
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      meal['img'] as String,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    meal['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ZaytooonTheme.darkText,
                    ),
                  ),
                  subtitle: Text(
                    meal['desc'],
                    style: const TextStyle(color: ZaytooonTheme.darkText),
                  ),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ZaytooonTheme.secondary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/details',
                        arguments: meal,
                      );
                    },
                    child: const Text('تفاصيل'),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}