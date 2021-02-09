package basic;

import java.util.List;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class ThumbJsonParser {
	private class Items {
		List<Key> items;
	}

	private class Key {
		String kind;
		String etag;
		String id;
		Snippet snippet;
		String channelTitle;
		
	}

	private class Localized {
		String title;
		String description;
	}

	private class Snippet {
		String publishedAt;
		String channelId;
		String title;
		String description;
		Thumbnails thumbnails;
		Localized localized;
	}

	private class Thumbnails {
		Medium medium;
		High high;
		Standard standard;
		Maxres maxres;
	}

	private class Medium {
		String url;
		int width;
		int height;
	}

	private class High {
		String url;
		int width;
		int height;
	}

	private class Standard {
		String url;
		int width;
		int height;
	}

	private class Maxres {
		String url;
		int width;
		int height;
	}

	public String getJson(String url) throws Exception {
		String json = readUrl(url);

		JsonElement jsonElement = new JsonParser().parse(json);
		Gson pretty = new GsonBuilder().setPrettyPrinting().create();

		String element = pretty.toJson(jsonElement);
		System.out.println(element);

		Gson gson = new Gson();
		Items ite = gson.fromJson(json, Items.class);

		Key k = ite.items.get(0);
		
		System.err.println(k.snippet.thumbnails.medium.url);

		return k.snippet.thumbnails.medium.url;
	}
	
	public String getlargethumb(String url) throws Exception {
		String json = readUrl(url);

		JsonElement jsonElement = new JsonParser().parse(json);
		Gson pretty = new GsonBuilder().setPrettyPrinting().create();

		String element = pretty.toJson(jsonElement);
		System.out.println(element);

		Gson gson = new Gson();
		Items ite = gson.fromJson(json, Items.class);

		Key k = ite.items.get(0);
		
		System.err.println(k.snippet.thumbnails.maxres.url);

		return k.snippet.thumbnails.maxres.url;
	}
	
	
	
	public String getDesc(String url) throws Exception {
		String json = readUrl(url);

		JsonElement jsonElement = new JsonParser().parse(json);
		Gson pretty = new GsonBuilder().setPrettyPrinting().create();

		String element = pretty.toJson(jsonElement);
		System.out.println(element);

		Gson gson = new Gson();
		Items ite = gson.fromJson(json, Items.class);

		Key k = ite.items.get(0);
		
		System.err.println(k.snippet.localized.description);

		return k.snippet.localized.description;
	}
	

	private static String readUrl(String urlString) throws Exception{
		BufferedReader reader = null;
		
		try {
			 URL url = new URL(urlString);
             reader = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
             StringBuffer buffer = new StringBuffer();

             int read = -1;
             char[] chars = new char[1024];
             while ((read = reader.read(chars)) != -1) {
                    buffer.append(chars, 0, read);
             }
             return buffer.toString();
		} finally {
            if (reader != null) {
                   reader.close();
            }
	}
	}
}

