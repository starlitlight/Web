package com.ifilmo.util;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class getImageSrc {
	
	public static List<String> getImageSrc(String htmlCode) {
	    List<String> imageSrcList = new ArrayList<String>();
	    Pattern p = Pattern.compile("<img\\b[^>]*\\bsrc\\b\\s*=\\s*('|\")?([^'\"\n\r\f>]+(\\.jpg|\\.bmp|\\.eps|\\.gif|\\.mif|\\.miff|\\.png|\\.tif|\\.tiff|\\.svg|\\.wmf|\\.jpe|\\.jpeg|\\.dib|\\.ico|\\.tga|\\.cut|\\.pic)\\b)[^>]*>", Pattern.CASE_INSENSITIVE);
	    System.out.println("HTML CODE IS " + htmlCode);
	    Matcher m = p.matcher(htmlCode);
	    String quote = null;
	    String src = null;
	    while (m.find()) {
	        quote = m.group(1);
	 
	        // src=https://sms.reyo.cn:443/temp/screenshot/zY9Ur-KcyY6-2fVB1-1FSH4.png
	        src = (quote == null || quote.trim().length() == 0) ? m.group(2).split("\\s+")[0] : m.group(2);
	        imageSrcList.add(src);
	 
	    }
	    return imageSrcList;
	}
	
	public static String Html2Text(String inputString){
		String htmlStr = inputString; //含html标签的字符串
		String textStr ="";
		java.util.regex.Pattern p_script;
		java.util.regex.Matcher m_script;
		java.util.regex.Pattern p_style;
		java.util.regex.Matcher m_style;
		java.util.regex.Pattern p_html;
		java.util.regex.Matcher m_html;
		try{
		String regEx_script = "<[\\s]*?script[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?script[\\s]*?>"; //定义script的正则表达式{或<script[^>]*?>[\\s\\S]*?<\\/script> }
		String regEx_style = "<[\\s]*?style[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?style[\\s]*?>"; //定义style的正则表达式{或<style[^>]*?>[\\s\\S]*?<\\/style> }
		String regEx_html = "<[^>]+>"; //定义HTML标签的正则表达式
		p_script = Pattern.compile(regEx_script,Pattern.CASE_INSENSITIVE);
		m_script = p_script.matcher(htmlStr);
		htmlStr = m_script.replaceAll(""); //过滤script标签
		p_style = Pattern.compile(regEx_style,Pattern.CASE_INSENSITIVE);
		m_style = p_style.matcher(htmlStr);
		htmlStr = m_style.replaceAll(""); //过滤style标签
		p_html = Pattern.compile(regEx_html,Pattern.CASE_INSENSITIVE);
		m_html = p_html.matcher(htmlStr);
		htmlStr = m_html.replaceAll(""); //过滤html标签
		textStr = htmlStr;
		}catch(Exception e){
			e.getMessage();
		}
		return textStr;//返回文本字符串
		}
	
//	public static void main(String[] args){
//		String content = "<p><img class='fr-dib' src='http://i.froala.com/download/fa7828d1ec63daa31cd41aa2ba666293322507da.jpg?1456621593' style='width: 300px;'>";
////		List<String> content2 = getImageSrc.getImageSrc(content);
////		for(String contents:  content2){
////			System.out.println(contents);
////		}
//		String value = getImageSrc.Html2Text(content);
//		System.out.println(value);
//	}

}