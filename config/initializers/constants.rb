# MOVIECENTER

MOVIE_FILMS_ENPOINT = 'https://api.movie.com.uy/api/billboard/cinema/weekly'
CINEMA_SHOWS_ENPOINT = 'https://api.movie.com.uy/api/shows/cinema/scheduledShows'

MOVIE_PRICES_ENDPOINT = 'https://api.movie.com.uy/api/shows/payments/options/list'

MOVIE_THEATER_ENPOINT = 'https://api.movie.com.uy/api/billboard/theater/weekly'
THEATER_SHOWS_ENPOINT = 'https://api.movie.com.uy/api/shows/theater/scheduledShows'


# TICKANTEL
TICKANTEL = 'http://tickantel.com.uy/inicio/'
TICKANTEL_THEATER_URL = TICKANTEL + 'buscarTeatro'
TICKANTEL_MUSIC_URL = TICKANTEL + 'buscarMusica'

DEFAULT_API_PER_PAGES = 20

EN = ['ENE','JANUARY']
FE = ['FEB','FEBRUARY']
MA = ['MAR','MARCH']
AB = ['ABR','APRIL']
JUN = ['JUN','JUNE']
JUL = ['JUL','JULY']
AG = ['AGO','AUGUST']
SE = ['SET','SEPTEMBER']
OC = ['OCT','OCTOBER']
NO = ['NOV','NOVEMBER']
DIC = ['DIC','DECEMBER']

MONTH_MAPPING = [EN,FE,MA,AB,MA,JUN,JUL,AG,SE,OC,NO,DIC]

VERDI_COORDS = { lat: -34.9082172, long: -56.19650039999999 }
SOLIS_COORDS = { lat: -34.9076753, long: -56.201114700000005 }
GALPON_COORDS = { lat: -34.904163, long: -56.18094189999999 }
AUDITORIO_NAC_COORDS = { lat: -34.9043938, long: -56.19844410000002 }
FLORENCIO_COORDS = { lat: -34.8923037, long: -56.247802999999976 }
CAMACUA_COORDS = { lat: -34.9091403, long: -56.20258990000002 }
ZITARROSA_COORDS = { lat: -34.9062588, long: -56.19456149999996 }
AUDITORIO_NELLY_COORDS = { lat: -34.9063649, long: -56.19631559999999 }
AGADU_COORDS = { lat: -34.9011127, long: -56.16453139999999 }
BLUZZ_COORDS = { lat: -34.896265, long: -56.173835 }
VELODROMO_COORDS = { lat: -34.89782539999999, long: -56.15590580000003 }
TALA_COORDS = { lat: -34.3437107, long: -55.763458000000014 }
CARNAVAL_COORDS = { lat: -34.9057284, long: -56.21217410000003 }
LAVALLEJA_COORDS = { lat: -34.3741805, long: -55.237645799999996 }
ANGLO_COORDS = { lat: -34.90655600000001, long: -56.18489679999999 }

EN_1 = ['Monday','Lunes']
FE_1 = ['Tuesday','Martes']
MA_1 = ['Wednesday','Miércoles']
AB_1 = ['Thursday','Jueves']
JUN_1 = ['Friday','Viernes']
JUL_1 = ['Saturday','Sábado']
AG_1 = ['Sunday','Domingo']

DAYS_MAPPING = [EN_1,FE_1,MA_1,AB_1,MA_1,JUN_1,JUL_1,AG_1]