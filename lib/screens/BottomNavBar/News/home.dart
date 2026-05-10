import 'package:flutter/material.dart';
import 'package:nilesisters/Localization/demo_localization.dart';
import 'package:nilesisters/Model/getHome.dart';
import 'package:nilesisters/Settings/ngo_ui.dart';
import 'package:nilesisters/Settings/SizeConfig.dart';
import 'package:nilesisters/screens/BottomNavBar/News/newsDetails.dart';
import 'package:nilesisters/utils/Utils.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return NgoPageShell(
      title: 'News Center',
      subtitle: 'Stories, updates, and public announcements from the NGO.',
      child: FutureBuilder<GetHome>(
        future: Utils().fetchhome(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final news = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 110),
            children: [
              const NgoSectionHeader(
                title: 'Latest stories',
                subtitle: 'A curated feed of recent posts, community highlights, and updates.',
              ),
              const SizedBox(height: 8),
              ...news.data.map(
                (item) => NgoCard(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(24),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetails(
                            news_detail_name: item.title,
                            news_detail_link: item.newsLink,
                            news_detail_text: item.description,
                            news_detail_category: item.category,
                            news_detail_image: '${Utils().image_base_url}${item.image}',
                            news_detail_date: '${item.createdAt.month}/${item.createdAt.day}/${item.createdAt.year}',
                          ),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Image.network(
                              '${Utils().image_base_url}${item.image}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                              decoration: BoxDecoration(
                                color: NgoPalette.sky,
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                item.category.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: NgoPalette.primary,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${item.createdAt.month}/${item.createdAt.day}/${item.createdAt.year}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: NgoPalette.muted,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: NgoPalette.ink,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.45,
                            color: NgoPalette.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
