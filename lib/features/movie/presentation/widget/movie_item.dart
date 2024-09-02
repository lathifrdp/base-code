import 'package:cached_network_image/cached_network_image.dart';
import 'package:coba/core/common/assets.dart';
import 'package:coba/core/common/helper.dart';
import 'package:coba/core/theme/style.dart';
import 'package:flutter/material.dart';

class MovieItem extends StatefulWidget {
  final void Function()? onTap;
  final String imageUrl;
  final String title;
  final String desc;
  final DateTime? date;
  final bool isLoadmore;
  final int index;

  const MovieItem({
    super.key,
    this.onTap,
    required this.title,
    required this.desc,
    required this.date,
    required this.imageUrl,
    required this.index,
    this.isLoadmore = false,
  });

  @override
  State<MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: widget.imageUrl,
                        height: 148,
                        width: 100,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Image.asset(
                          Assets.placeholderWide,
                          width: 100,
                          height: 148,
                          fit: BoxFit.fill,
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          Assets.placeholderWide,
                          width: 100,
                          height: 142,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 2,
                      left: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Styles().color.secondary,
                          shape: BoxShape.circle,
                        ),
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          (widget.index + 1).toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 10,
                              color: Styles().color.onSecondary),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.favorite_rounded,
                                size: 12,
                                color: Styles().color.primary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '14K',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Styles().color.onSecondaryContainer,
                                    fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                          const SizedBox(width: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.star_rounded,
                                size: 16,
                                color: Styles().color.primary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '9/10',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Styles().color.onSecondaryContainer,
                                    fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                          const Expanded(child: SizedBox()),
                          Text(
                            Helper.formatDateTime(widget.date,
                                format: 'dd MMM yyyy'),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.desc,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            widget.isLoadmore
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
