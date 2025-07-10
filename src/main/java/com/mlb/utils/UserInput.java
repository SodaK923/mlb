package com.mlb.utils;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Scanner;

public class UserInput {

		private static Scanner sc = new Scanner(System.in);

		public static int inputInt(String st) {
			System.out.println(st + " int 정수를 입력하세요.>>");
			return Integer.parseInt(sc.nextLine());
		}
		
		public static long inputLong(String st) {
			System.out.println(st + " long 정수를 입력하세요.>>");
			return Long.parseLong(sc.nextLine());
		}

		public static double inputDouble(String st) {
			System.out.println(st + " 키를 입력하세요.>>");
			return Double.parseDouble(sc.nextLine());
		}

		public static String inputString(String st) {
			System.out.println(st + " 문자열을 입력하세요.>>");
			return sc.nextLine();
		}

		public static LocalDateTime inputLocalDateTime(String str) {
			System.out.println(str + " 시간을 입력하세요.(yyyy-MM-dd HH:mm:ss)>>");
			return LocalDateTime.parse(sc.nextLine(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
		}

		public static String dateToString(LocalDateTime date) {
			return date.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
		}
}
