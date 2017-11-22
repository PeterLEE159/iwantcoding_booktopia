package kr.go.booktopia.config;

public class Http {
	
	public static String baseUri = null;
	private static boolean isAlive = false;
	
	static {
		if(isAlive ) {
			baseUri = "";
		} else {
			baseUri = "http://192.168.10.99/";
		}
	}
	
}
