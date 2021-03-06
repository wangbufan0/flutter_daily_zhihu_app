import 'package:flutterdailyzhihuapp/news_data_entity.dart';

newsDataEntityFromJson(NewsDataEntity data, Map<String, dynamic> json) {
	if (json['date'] != null) {
		data.date = json['date']?.toString();
	}
	if (json['stories'] != null) {
		data.stories = new List<NewsDataStory>();
		(json['stories'] as List).forEach((v) {
			data.stories.add(new NewsDataStory().fromJson(v));
		});
	}
	if (json['top_stories'] != null) {
		data.topStories = new List<NewsDataTopStory>();
		(json['top_stories'] as List).forEach((v) {
			data.topStories.add(new NewsDataTopStory().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> newsDataEntityToJson(NewsDataEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['date'] = entity.date;
	if (entity.stories != null) {
		data['stories'] =  entity.stories.map((v) => v.toJson()).toList();
	}
	if (entity.topStories != null) {
		data['top_stories'] =  entity.topStories.map((v) => v.toJson()).toList();
	}
	return data;
}

newsDataStoryFromJson(NewsDataStory data, Map<String, dynamic> json) {
	if (json['image_hue'] != null) {
		data.imageHue = json['image_hue']?.toString();
	}
	if (json['title'] != null) {
		data.title = json['title']?.toString();
	}
	if (json['url'] != null) {
		data.url = json['url']?.toString();
	}
	if (json['hint'] != null) {
		data.hint = json['hint']?.toString();
	}
	if (json['ga_prefix'] != null) {
		data.gaPrefix = json['ga_prefix']?.toString();
	}
	if (json['images'] != null) {
		data.images = json['images']?.map((v) => v?.toString())?.toList()?.cast<String>();
	}
	if (json['type'] != null) {
		data.type = json['type']?.toInt();
	}
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	return data;
}

Map<String, dynamic> newsDataStoryToJson(NewsDataStory entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['image_hue'] = entity.imageHue;
	data['title'] = entity.title;
	data['url'] = entity.url;
	data['hint'] = entity.hint;
	data['ga_prefix'] = entity.gaPrefix;
	data['images'] = entity.images;
	data['type'] = entity.type;
	data['id'] = entity.id;
	return data;
}

newsDataTopStoryFromJson(NewsDataTopStory data, Map<String, dynamic> json) {
	if (json['image_hue'] != null) {
		data.imageHue = json['image_hue']?.toString();
	}
	if (json['hint'] != null) {
		data.hint = json['hint']?.toString();
	}
	if (json['url'] != null) {
		data.url = json['url']?.toString();
	}
	if (json['image'] != null) {
		data.image = json['image']?.toString();
	}
	if (json['title'] != null) {
		data.title = json['title']?.toString();
	}
	if (json['ga_prefix'] != null) {
		data.gaPrefix = json['ga_prefix']?.toString();
	}
	if (json['type'] != null) {
		data.type = json['type']?.toInt();
	}
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	return data;
}

Map<String, dynamic> newsDataTopStoryToJson(NewsDataTopStory entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['image_hue'] = entity.imageHue;
	data['hint'] = entity.hint;
	data['url'] = entity.url;
	data['image'] = entity.image;
	data['title'] = entity.title;
	data['ga_prefix'] = entity.gaPrefix;
	data['type'] = entity.type;
	data['id'] = entity.id;
	return data;
}