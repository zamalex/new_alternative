import 'package:alternative_new/main.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

import '../Model/country.dart';

class CountryDropdown extends StatefulWidget {
  final int selectedCountryId;
  final Function? onSelect;

  const CountryDropdown({Key? key, this.selectedCountryId = 0, this.onSelect}) : super(key: key);

  @override
  _CountryDropdownState createState() => _CountryDropdownState();
}

class _CountryDropdownState extends State<CountryDropdown> {
  int? _selectedCountryId;

  @override
  void initState() {
    super.initState();
    _selectedCountryId = widget.selectedCountryId != 0 ? widget.selectedCountryId : null;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
     // iconSize: 0.0,  // Hides the default arrow icon
      padding: EdgeInsets.zero,
      value: _selectedCountryId,
      hint: CountryFlag.fromCountryCode(
        countryToCode[getCountryNameById(_selectedCountryId ?? 65)] ?? 'EG',
        width: 30,
        height: 20,
      ),
      isExpanded: true,
      items: countries.map((Country country) {
        return DropdownMenuItem<int>(
          value: country.id,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CountryFlag.fromCountryCode(
                  countryToCode[country.name] ?? 'EG',
                  width: 30,
                  height: 20,
                ),
                SizedBox(width: 8),  // Space between flag and name
                Text(country.name),
              ],
            ),
          ),
        );
      }).toList(),
      onChanged: (int? newValue) {
        setState(() {
          CountryId = newValue;
          _selectedCountryId = newValue;

          if (widget.onSelect != null) {
            widget.onSelect!();
          }
        });
      },
      selectedItemBuilder: (BuildContext context) {
        return countries.map<Widget>((Country country) {
          if (country.id == _selectedCountryId) {
            return CountryFlag.fromCountryCode(
              countryToCode[country.name] ?? 'EG',
              width: 30,
              height: 10,

            );
          } else {
            return Container();  // Return an empty widget if not selected
          }
        }).toList();
      },
    );
  }
}

int getCountryIdByName(String countryName) {
  try {
    return countries.firstWhere((country) => country.name.toLowerCase() == countryName.toLowerCase()).id;
  } catch (e) {
    return 65; // Return null if no country with the given name is found
  }
}

String getCountryNameById(int id) {
  try {
    return countries.firstWhere((country) => country.id == id).name;
  } catch (e) {
    return 'Egypt'; // Return null if no country with the given name is found
  }
}
Map<String, String> countryToCode = {
  "Afghanistan": "AF",
  "Aland Islands": "AX",
  "Albania": "AL",
  "Algeria": "DZ",
  "American Samoa": "AS",
  "Andorra": "AD",
  "Angola": "AO",
  "Anguilla": "AI",
  "Antarctica": "AQ",
  "Antigua and Barbuda": "AG",
  "Argentina": "AR",
  "Armenia": "AM",
  "Aruba": "AW",
  "Australia": "AU",
  "Austria": "AT",
  "Azerbaijan": "AZ",
  "Bahrain": "BH",
  "Bangladesh": "BD",
  "Barbados": "BB",
  "Belarus": "BY",
  "Belgium": "BE",
  "Belize": "BZ",
  "Benin": "BJ",
  "Bermuda": "BM",
  "Bhutan": "BT",
  "Bolivia": "BO",
  "Bonaire, Sint Eustatius and Saba": "BQ",
  "Bosnia and Herzegovina": "BA",
  "Botswana": "BW",
  "Bouvet Island": "BV",
  "Brazil": "BR",
  "British Indian Ocean Territory": "IO",
  "Brunei": "BN",
  "Bulgaria": "BG",
  "Burkina Faso": "BF",
  "Burundi": "BI",
  "Cambodia": "KH",
  "Cameroon": "CM",
  "Canada": "CA",
  "Cape Verde": "CV",
  "Cayman Islands": "KY",
  "Central African Republic": "CF",
  "Chad": "TD",
  "Chile": "CL",
  "China": "CN",
  "Christmas Island": "CX",
  "Cocos [Keeling] Islands": "CC",
  "Colombia": "CO",
  "Comoros": "KM",
  "Congo": "CG",
  "Cook Islands": "CK",
  "Costa Rica": "CR",
  "Cote D'Ivoire [Ivory Coast]": "CI",
  "Croatia": "HR",
  "Cuba": "CU",
  "Curaçao": "CW",
  "Cyprus": "CY",
  "Czech Republic": "CZ",
  "Democratic Republic of the Congo": "CD",
  "Denmark": "DK",
  "Djibouti": "DJ",
  "Dominica": "DM",
  "Dominican Republic": "DO",
  "Ecuador": "EC",
  "Egypt": "EG",
  "El Salvador": "SV",
  "Equatorial Guinea": "GQ",
  "Eritrea": "ER",
  "Estonia": "EE",
  "Eswatini": "SZ",
  "Ethiopia": "ET",
  "Falkland Islands": "FK",
  "Faroe Islands": "FO",
  "Fiji Islands": "FJ",
  "Finland": "FI",
  "France": "FR",
  "French Guiana": "GF",
  "French Polynesia": "PF",
  "French Southern Territories": "TF",
  "Gabon": "GA",
  "Gambia The": "GM",
  "Georgia": "GE",
  "Germany": "DE",
  "Ghana": "GH",
  "Gibraltar": "GI",
  "Greece": "GR",
  "Greenland": "GL",
  "Grenada": "GD",
  "Guadeloupe": "GP",
  "Guam": "GU",
  "Guatemala": "GT",
  "Guernsey and Alderney": "GG",
  "Guinea": "GN",
  "Guinea-Bissau": "GW",
  "Guyana": "GY",
  "Haiti": "HT",
  "Heard Island and McDonald Islands": "HM",
  "Holland": "NL",  // Holland is a region in the Netherlands
  "Honduras": "HN",
  "Hong Kong S.A.R.": "HK",
  "Hungary": "HU",
  "Iceland": "IS",
  "India": "IN",
  "Indonesia": "ID",
  "Iran": "IR",
  "Iraq": "IQ",
  "Ireland": "IE",
  "Israel": "IL",
  "Italy": "IT",
  "Jamaica": "JM",
  "Japan": "JP",
  "Jersey": "JE",
  "Jordan": "JO",
  "Kazakhstan": "KZ",
  "Kenya": "KE",
  "Kiribati": "KI",
  "Kosovo": "XK",
  "Kuwait": "KW",
  "Kyrgyzstan": "KG",
  "Laos": "LA",
  "Latvia": "LV",
  "Lebanon": "LB",
  "Lesotho": "LS",
  "Liberia": "LR",
  "Libya": "LY",
  "Liechtenstein": "LI",
  "Lithuania": "LT",
  "Luxembourg": "LU",
  "Macau S.A.R.": "MO",
  "Madagascar": "MG",
  "Malawi": "MW",
  "Malaysia": "MY",
  "Maldives": "MV",
  "Mali": "ML",
  "Malta": "MT",
  "Man [Isle of]": "IM",
  "Marshall Islands": "MH",
  "Martinique": "MQ",
  "Mauritania": "MR",
  "Mauritius": "MU",
  "Mayotte": "YT",
  "Mexico": "MX",
  "Micronesia": "FM",
  "Moldova": "MD",
  "Monaco": "MC",
  "Mongolia": "MN",
  "Montenegro": "ME",
  "Montserrat": "MS",
  "Morocco": "MA",
  "Mozambique": "MZ",
  "Myanmar": "MM",
  "Namibia": "NA",
  "Nauru": "NR",
  "Nepal": "NP",
  "Netherlands": "NL",
  "New Caledonia": "NC",
  "New Zealand": "NZ",
  "Nicaragua": "NI",
  "Niger": "NE",
  "Nigeria": "NG",
  "Niue": "NU",
  "Norfolk Island": "NF",
  "North Korea": "KP",
  "North Macedonia": "MK",
  "Northern Mariana Islands": "MP",
  "Norway": "NO",
  "Oman": "OM",
  "Pakistan": "PK",
  "Palau": "PW",
  "Palestinian Territory Occupied": "PS",
  "Panama": "PA",
  "Papua New Guinea": "PG",
  "Paraguay": "PY",
  "Peru": "PE",
  "Philippines": "PH",
  "Pitcairn Island": "PN",
  "Poland": "PL",
  "Portugal": "PT",
  "Puerto Rico": "PR",
  "Qatar": "QA",
  "Reunion": "RE",
  "Romania": "RO",
  "Russia": "RU",
  "Rwanda": "RW",
  "Saint Helena": "SH",
  "Saint Kitts and Nevis": "KN",
  "Saint Lucia": "LC",
  "Saint Pierre and Miquelon": "PM",
  "Saint Vincent and the Grenadines": "VC",
  "Saint-Barthelemy": "BL",
  "Saint-Martin [French part]": "MF",
  "Samoa": "WS",
  "San Marino": "SM",
  "Sao Tome and Principe": "ST",
  "Saudi Arabia": "SA",
  "Scotland": "GB-SCT",
  "Senegal": "SN",
  "Serbia": "RS",
  "Seychelles": "SC",
  "Sierra Leone": "SL",
  "Singapore": "SG",
  "Sint Maarten [Dutch part]": "SX",
  "Slovakia": "SK",
  "Slovenia": "SI",
  "Solomon Islands": "SB",
  "Somalia": "SO",
  "South Africa": "ZA",
  "South Georgia": "GS",
  "South Korea": "KR",
  "South Sudan": "SS",
  "Spain": "ES",
  "Sri Lanka": "LK",
  "Sudan": "SD",
  "Suriname": "SR",
  "Svalbard and Jan Mayen Islands": "SJ",
  "Sweden": "SE",
  "Switzerland": "CH",
  "Syria": "SY",
  "Taiwan": "TW",
  "Tajikistan": "TJ",
  "Tanzania": "TZ",
  "Thailand": "TH",
  "The Bahamas": "BS",
  "Timor-Leste": "TL",
  "Togo": "TG",
  "Tokelau": "TK",
  "Tonga": "TO",
  "Trinidad and Tobago": "TT",
  "Tunisia": "TN",
  "Turkey": "TR",
  "Turkmenistan": "TM",
  "Turks and Caicos Islands": "TC",
  "Tuvalu": "TV",
  "Uganda": "UG",
  "Ukraine": "UA",
  "United Arab Emirates": "AE",
  "United Kingdom": "GB",
  "United States": "US",
  "United States Minor Outlying Islands": "UM",
  "Uruguay": "UY",
  "Uzbekistan": "UZ",
  "Vanuatu": "VU",
  "Vatican City State [Holy See]": "VA",
  "Venezuela": "VE",
  "Vietnam": "VN",
  "Virgin Islands [British]": "VG",
  "Virgin Islands [US]": "VI",
  "Wallis and Futuna Islands": "WF",
  "Western Sahara": "EH",
  "Yemen": "YE",
  "Zambia": "ZM",
  "Zimbabwe": "ZW"
};
