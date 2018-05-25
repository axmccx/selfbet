enum BetType {
  alarmClock,
  location,
  comms,
  mock
}

String typeToString(BetType type) {
  switch(type) {
    case BetType.alarmClock: {
      return 'Alarm Clock';
    }
    case BetType.comms: {
      return 'Communication';
    }
    case BetType.location: {
      return 'Location';
    }
    case BetType.mock: {
      return 'Mock';
    }
  }
  return "error";
}

String getTypeMsg(BetType type) {
  switch(type) {
    case BetType.comms: {
      return 'that I will text or call,';
    }
    case BetType.alarmClock: {
      return 'that I will not snooze my alarm,';
    }
    case BetType.location: {
      return 'that I will visit the following location,';
    }
    case BetType.mock: {
      return 'mock bet for testing';
    }
    default: {
      return "";
    }
  }
}