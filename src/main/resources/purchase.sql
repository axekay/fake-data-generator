CREATE (person:Person { PersonId:1001, FirstName: "Ram", MiddleName: "Kumar", LastName:"Sharma", Gender:"Male", DateOfBirth: 19901225})

CREATE (product:Product {ProductId:2001, Name: "Spiced Butter Milk", Description: "", Brand: "Amul", Company: "Amul", ModelNumber: "8901262200233",ExternalLink:"https://www.amazon.in/dp/B00TX90RXO"})

CREATE (productInstance:ProductInstance{ ProductInstanceId:200001, ProductId: 2001, Quantity:1, UnitOfMeasurement: "litre", PriceRate: 50.00, ImageURL: "https://images-na.ssl-images-amazon.com/images/I/41DFs8pVPzL.jpg"} )

CREATE (dt: DateTime {DateTimeId:20201115134010, Day:15, Month:11, Year:2020, Hour:13, Minute:40, Second: 10, Zone: "IST"} )

CREATE (dt2: DateTime {DateTimeId:20200512000000, Day:12, Month:05, Year:2020, Hour:00, Minute:00, Second: 00, Zone: "IST"} )

CREATE (dt3: DateTime {DateTimeId:20210212000000, Day:12, Month:02, Year:2021, Hour:00, Minute:00, Second: 00, Zone: "IST"} )

CREATE (payment:Payment {PaymentId: 3001, Type: "Debit", Amount: 50, Currency: "INR", TransactionId: "R0123PA38122", ProofURL: "abc.png"})

CREATE (paymentMode:PaymentMode{PaymentModeId:4001, Name:"HDFC NetBanking", ID: "ipoiewq093123"})

CREATE (bill:Bill {BillId:5001, BillNumber: "BSPE123412002A", ImageURL: "bill5001.png", GSTNo: "", Amount:50, Currency: "INR"})

CREATE (company:Company {CompanyId:6001, Name:"Amul"})

CREATE (address:Address{AddressId:7001, Name: "DMart", Street: "DB Mall", City: "Bhopal"})

CREATE (address2:Address{AddressId:7002, Name: "Home", House: "C-6", Apartment: "Fortune Park", Street: "Gulmohar Colony", City: "Bhopal"})


MATCH ( person : Person { PersonId:1001 } )
MATCH ( productInstance )




MATCH (person:Person), (productInstance:ProductInstance)
WHERE person.PersonId = 1001 and productInstance.ProductInstanceId = 200001
CREATE (person)-[r:BOUGHT]->(productInstance)

MATCH (person:Person), (address:Address)
WHERE person.PersonId = 1001 and address.AddressId = 7002
CREATE (person)-[r:LIVES_AT]->(address)

MATCH (product : Product), (productInstance:ProductInstance)
WHERE product.ProductId = 2001 and productInstance.ProductInstanceId = 200001
CREATE (productInstance)-[r:INSTANCE_OF]->(product)

MATCH (datetime : DateTime), (productInstance : ProductInstance)
WHERE datetime.DateTimeId = 20201115134010  and productInstance.ProductInstanceId = 200001
CREATE (productInstance)-[r:BOUGHT_ON]->(datetime)

MATCH (datetime : DateTime), (productInstance : ProductInstance)
WHERE datetime.DateTimeId = 20200512000000  and productInstance.ProductInstanceId = 200001
CREATE (productInstance)-[r:MANUFACTURED_ON]->(datetime)

MATCH (datetime : DateTime), (productInstance : ProductInstance)
WHERE datetime.DateTimeId = 20210212000000  and productInstance.ProductInstanceId = 200001
CREATE (productInstance)-[r:EXPIRES_ON]->(datetime)

MATCH (person : Person), (payment : Payment)
WHERE person.PersonId = 1001 and payment.PaymentId = 3001
CREATE (person)-[r:PAID]->(payment),(payment)-[t:TRANSACTION_SOURCE]->(person)


MATCH (payment : Payment), (paymentMode : PaymentMode)
WHERE payment.PaymentId = 3001 and paymentMode.PaymentModeId = 4001
CREATE (payment)-[r:TRANSACTION_USING]->(paymentMode)

MATCH (company : Company), (payment : Payment)
WHERE company.CompanyId = 6001 and payment.PaymentId = 3001
CREATE (payment)-[r:TRANSACTION_DESTINATION]->(company)

MATCH (datetime : DateTime), (payment : Payment)
WHERE datetime.DateTimeId = 20201115134010  and payment.PaymentId = 3001
CREATE (payment)-[r:TRANSACTION_ON]->(datetime)

MATCH (productInstance : ProductInstance), (address : Address)
WHERE productInstance.ProductInstanceId = 200001 and address.AddressId = 7001
CREATE (productInstance)-[r:BOUGHT_FROM]->(address)

MATCH (productInstance : ProductInstance), (bill : Bill)
WHERE productInstance.ProductInstanceId = 200001 and bill.BillId = 5001
CREATE (productInstance)-[r:BILLED_IN]->(bill)

MATCH (datetime : DateTime), (bill : Bill)
WHERE datetime.DateTimeId = 20201115134010 and bill.BillId = 5001
CREATE (bill)-[r:DUE_ON]->(datetime), (bill)-[p:PAID_ON]->(datetime), (bill)-[g:GENERATED_ON]->(datetime)

MATCH (company : Company), (address : Address)
WHERE company.CompanyId = 6001 and address.AddressId = 7001
CREATE (company)-[r:LOCATED_AT]->(address)

MATCH (company : Company), (bill : Bill)
WHERE company.CompanyId = 6001 and bill.BillId = 5001
CREATE (bill)-[r:GENERATED_BY]->(company)

MATCH (address : Address), (bill : Bill)
WHERE address.AddressId = 7001 and bill.BillId = 5001
CREATE (bill)-[r:GENERATED_AT]->(address)

MATCH (payment : Payment), (bill : Bill)
WHERE payment.PaymentId = 3001 and bill.BillId = 5001
CREATE (bill)-[r:PAYMENT_DONE]->(payment), (payment)-[f:PAYMENT_FOR]->(bill)
