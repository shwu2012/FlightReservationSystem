import random

# all passenger IDs
passenger_ids = [s.strip().split('\t')[0] for s in open('../passenger.txt').readlines() if s.strip()]
assert len(passenger_ids) > 3

# all tickets IDs by date
tickets = [s.strip().split('\t') for s in open('../ticket.txt').readlines() if s.strip()]
tickets_by_date = {}
dates_of_tickets = []
for t in tickets:
    ticket_date = t[2]
    if ticket_date not in tickets_by_date:
        tickets_by_date[ticket_date] = []
        dates_of_tickets.append(ticket_date)
    tickets_by_date[ticket_date].append(t[0])
dates_of_tickets.sort()

# generate reservations day-by-day
reservation_id = 0
for d in dates_of_tickets:
    buyer_count = random.randint(3, len(passenger_ids))
    selected_passenger_ids = random.sample(passenger_ids, buyer_count)
    ticket_ids = tickets_by_date[d]
    assert len(ticket_ids) >= buyer_count
    selected_ticket_ids = random.sample(ticket_ids, buyer_count)
    for i in range(buyer_count):
        # e.g. 'R00000000001	P000000001	T000000001'
        reservation_id += 1
        print 'R%s\t%s\t%s' % (
            str(reservation_id).zfill(11),
            selected_passenger_ids[i],
            selected_ticket_ids[i])
