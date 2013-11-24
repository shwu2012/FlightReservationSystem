from datetime import timedelta
from datetime import date
import random

# all seat classes
seat_classes = ['E', 'F', 'B']

# all flight numbers
flight_records = [s.strip().split('\t') for s in open('../flight.txt').readlines() if s.strip()]
flight_numbers = [(s[0], s[-1] == '1') for s in flight_records]

# all dates
start_date = date(2013, 12, 25)
end_date = date(2014, 1, 10)
dates = []
while(start_date <= end_date):
    dates.append(start_date)
    start_date += timedelta(days=1)

# generate all tickets
ticket_id = 0
for f in flight_numbers:
    if f[1]:
        flight_based_price = random.uniform(300, 500)
    else:
        flight_based_price = random.uniform(100, 150) # same-day flight should be cheaper
    for d in dates:
        flight_price_one_day = random.gauss(flight_based_price, 50)
        for s in seat_classes:
            ticket_id += 1
            depart_date = d
            arrival_date = d
            if f[1]: # overnight
                arrival_date += timedelta(days=1)
            ticket_number = random.randint(10, 200)
            price = flight_price_one_day # price of seat E
            if s == 'B':
                price += 70
            if s == 'F':
                price += 85
            if price < 50:
                price = 50.0 # min price
            # e.g. 'T000000001	UA858	2013-11-10	2013-11-10	E	39	600'
            print 'T%s\t%s\t%s\t%s\t%s\t%d\t%d' % (
                str(ticket_id).zfill(9), f[0], depart_date, arrival_date, s, ticket_number, int(price))
            
