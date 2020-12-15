package com.axekay.faker;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;
import com.github.javafaker.Address;
import com.github.javafaker.Faker;
import com.github.javafaker.Internet;
import com.github.javafaker.Name;

public class Profile {

  String delimiter;

  long id;

  String guid;

  // varchar
  String firstName;

  // varchar
  String lastName;

  // varchar
  String email;

  // varchar
  String ip;

  // varchar
  String username;

  String gender;

  // varchar
  String country;

  // varchar
  String city;

  // varchar
  String streetName;

  // varchar
  String zipCode;

  // decimal
  String longitude;

  // decimal
  String latitude;

  String birthdate;

  String birthdatetime;

  double score;

  double affinity;

  double transactionAmt;

  int transactionCount;

  long timestamp;

  String isSpecial;

  String isPremium;

  public Profile(Faker faker, long seed, String delimiter) {
    this.id = seed * 10000000000000000L + System.nanoTime();
    Name name = faker.name();
    this.firstName = name.firstName();
    this.lastName = name.lastName();
    this.username = firstName.replaceAll("'", "").toLowerCase() + "." + lastName.replaceAll("'", "").toLowerCase();
    this.gender = faker.regexify("[mfu]");
    Internet internet = faker.internet();
    // this.email = internet.emailAddress();
    this.email = internet.emailAddress(username);
    this.ip = internet.ipV4Address();
    Address address = faker.address();
    this.latitude = address.latitude();
    this.longitude = address.longitude();
    this.country = address.country();
    this.streetName = address.streetName();
    this.zipCode = address.zipCode();
    this.city = address.city();
    Date date = faker.date().birthday(18, 70);
    this.birthdate = new SimpleDateFormat("yyyy-MM-dd").format(date);
    this.birthdatetime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
    this.guid = UUID.randomUUID().toString();
    this.score = faker.number().randomDouble(10, 0, 1);
    this.affinity = faker.number().randomDouble(21, -1, 1);
    this.transactionAmt = faker.number().randomDouble(4, 1, 65000);
    this.transactionCount = faker.number().numberBetween(1, 65000);
    this.timestamp = System.currentTimeMillis();
    this.isSpecial = String.valueOf(faker.random().nextBoolean());
    this.isPremium = String.valueOf(faker.random().nextInt(0, 1));
    this.delimiter = delimiter;
  }

  public String getHeader() {
    return String.join(delimiter, "id", "guid", "firstName", "lastName", "email", "username", "gender", "birthdate",
        "birthdatetime", "ip", "country", "city", "streetName", "zipCode", "longitude", "latitude", "score", "affinity",
        "transactionAmt", "transactionCount", "timestamp", "isSpecial", "isPremium");
  }

  public String toDelimited() {
    return String.join(delimiter, String.valueOf(id), guid, firstName, lastName, email, username, gender, birthdate,
        birthdatetime, ip, country, city, streetName, zipCode, longitude, latitude, String.valueOf(score), String
            .valueOf(affinity), String.valueOf(transactionAmt), String.valueOf(transactionCount), String.valueOf(
                timestamp), isSpecial, isPremium);
  }
}
