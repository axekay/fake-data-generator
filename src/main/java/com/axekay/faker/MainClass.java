package com.axekay.faker;

import java.io.File;
import com.github.javafaker.Faker;

public class MainClass {

  public static void main(String[] args) {
    File fils = new File("asdasd");
    // int seed = Integer.valueOf(args[0]); //
    int seed = 12;
    if (args.length > 0) {
      seed = Integer.valueOf(args[0]);
    }
    if (!(seed > 0 && seed < 100)) {
      // Greater than 0 and less than 1 hundred
      System.err.print("Invalid seed. Provide value > 0 and < 100");
      return;
    }
    int records = 10;
    if (args.length > 1) {
      records = Integer.valueOf(args[1]);
    }
    if (records <= 0) {
      System.err.print("Invalid records. Provide positive number");
      return;
    }
    Faker faker = new Faker();
    System.out.println(new Profile(faker, seed,"|").getHeader());
    for (int i = 0; i < records; i++) {
      Profile profile = new Profile(faker, seed,"|");
      System.out.println(profile.toDelimited());
    }
  }
  
}

