// to represent a book in a bookstore
class Book {
  String title;
  Author author;
  int price;
  Publisher publisher;
 
  // the constructor
  Book(String title, Author author, int price, Publisher publisher) {
    this.title = title;
    this.author = author;
    this.price = price;
	this.publisher = publisher;
  }
}
 
// to represent a author of a book in a bookstore
class Author {
  String name;
  int yob;
 
  // the constructor
  Author(String name, int yob) {
    this.name = name;
    this.yob = yob;
  }
}

class Publisher {
	String name;
	String country;
	int year;
}