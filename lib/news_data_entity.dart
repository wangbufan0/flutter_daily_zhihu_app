import 'package:flutterdailyzhihuapp/generated/json/base/json_convert_content.dart';
import 'package:flutterdailyzhihuapp/generated/json/base/json_filed.dart';

class NewsDataEntity with JsonConvert<NewsDataEntity> {
	String date;
	List<NewsDataStory> stories;
	@JSONField(name: "top_stories")
	List<NewsDataTopStory> topStories;
}

class NewsDataStory with JsonConvert<NewsDataStory> {
	@JSONField(name: "image_hue")
	String imageHue;
	String title;
	String url;
	String hint;
	@JSONField(name: "ga_prefix")
	String gaPrefix;
	List<String> images;
	int type;
	int id;
}

class NewsDataTopStory with JsonConvert<NewsDataTopStory> {
	@JSONField(name: "image_hue")
	String imageHue;
	String hint;
	String url;
	String image;
	String title;
	@JSONField(name: "ga_prefix")
	String gaPrefix;
	int type;
	int id;
}
