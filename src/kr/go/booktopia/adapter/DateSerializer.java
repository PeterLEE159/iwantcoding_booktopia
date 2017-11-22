package kr.go.booktopia.adapter;

import java.lang.reflect.Type;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.google.gson.JsonElement;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;

public class DateSerializer implements JsonSerializer<Date> {

	private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

	@Override
	public JsonElement serialize(Date date, Type type, JsonSerializationContext contex) {
		if (date == null) {
			return new JsonPrimitive("");
		} else {
			return new JsonPrimitive(dateFormat.format(date));
		}
	}
}
