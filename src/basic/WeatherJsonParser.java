package basic;

import java.util.List;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class WeatherJsonParser {
	private class Weather {
		List<Key> weather;
	}

	private class Key {
		String id;
		String main;
		String description;
		String icon;
			
	}

	public String getJson(String url) throws Exception {
		String json = readUrl(url);

		JsonElement jsonElement = new JsonParser().parse(json);
		Gson pretty = new GsonBuilder().setPrettyPrinting().create();

		String element = pretty.toJson(jsonElement);
		System.out.println(element);

		Gson gson = new Gson();
		Weather wea = gson.fromJson(json, Weather.class);

		Key k = wea.weather.get(0);
		
		System.err.println(k.main);

		return k.main;
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

