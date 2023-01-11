


/*
Basic functionalities
1.Given that the passenger hasn't already registered, will allow to create an account.
2.The passenger needs to finish KYC by uploading a pdf of any ID.
3.Given that the passenger has already booked a ticket, will allow to link the PNR number to their account, view all the list bookings done so far.
4.The passenger can reserve a seat for their bookings, once checked out, will be able to get their boarding pass also will be able to print it(Ctrl P).
5.The boarding pass will contain the passenger details, scannable QR code of their PNR number, seat number and extra cost that needs to be paid in case the seat reserved is a window seat.
6.The aiport agent will be able to scan the QR code and check the passenger details
7.The airport agent can enter the flight ID and grab the passenger list.
8.The agent can accept upon scanning a particular boarding pass, and reject if the passenger is boarding a wrong flight(Where upon scanning the QR code will not be able to get any details).
9.Both passengers and agents can update/modify their profiles.
*/


--Tables

--users   (user_name,email,pswd)
--flight_schedule  (flight_id,flight_name,Aircraft_id,fight_date,Departure_time,Arrival_time,to,from,net_fare,is_international)
--Aircraft(Aircraft_id,Aircraft_name,flight_id,seats)
--Booking (booking_id,passport_id,passenger_name,gender,email,mobile,DOB,city,country,pincode,from,to,flight_id,seat_id)
--passenger(passenger_name,gender,email,mobile,DOB,city,country,pincode,from,to,flight_id)
--seats(Aircaft_id,seatid,class,fare)
--booking_Cancellations(user_id,booking_id,flight_id,netfare)---by trigger we can insert into this table if any booking id is deleted
--flight_cancellations(flight_id,Aircraft_id)
--Refunds(booking_id,refund_Amt)
--Transactions(user_id,booking_id,dicount_id,transaction_id,Amount_paid)
--feedback(user_id,rating,comments)

/*

--functionalities

login

seraching flights
finding the seats avilability
flight timings
booking ticket
payment for tickets
cancelling tickets
*/

CREATE DATABASE IF NOT EXISTS 'Airline_Reservation_db' ;

CREATE TABLE Passenger
(
  passenger_id,
  first_name,
  last_name,
  phone,
  email,
  passport_id,
  pincode,
  country_code
);

CREATE TABLE country
(
    country_code,
    country_name
);

CREATE TABLE Airport
(
    airport_code,
    airport_name,
    city,
    country_code

);

CREATE TABLE

CREATE TABLE Booking
(
    passenger_id,
    airport_code,
    boarding_time,
    dropping_time,
    from_citycode,
    to_code,
    aircraft_id,
    seat_id,
);



CREATE TABLE FlightSeatPrice
(
    flight_id,
    seat_id,
    class_id,
    price
);