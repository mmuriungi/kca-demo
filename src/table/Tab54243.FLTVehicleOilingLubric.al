table 54243 "FLT-Vehicle Oiling & Lubric"
{

    fields
    {
        field(1; "Oiling Id"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Reg. No."; Code[20])
        {
        }
        field(3; "Oiling Date"; Date)
        {

            trigger OnValidate()
            begin
                months := 0;
                if "Oiling Date" <> 0D then begin
                    Year := Date2DMY("Oiling Date", 3);
                    months := Date2DMY("Oiling Date", 2);

                    if months = 1 then
                        Month := Month::JANUARY else
                        if months = 2 then
                            Month := Month::FEBRUARY else
                            if months = 3 then
                                Month := Month::MARCH else
                                if months = 4 then
                                    Month := Month::APRIL else
                                    if months = 5 then
                                        Month := Month::MAY else
                                        if months = 6 then
                                            Month := Month::JUNE else
                                            if months = 7 then
                                                Month := Month::JULY else
                                                if months = 8 then
                                                    Month := Month::AUGUST else
                                                    if months = 9 then
                                                        Month := Month::SEPTEMBER else
                                                        if months = 10 then
                                                            Month := Month::OCTOBER else
                                                            if months = 11 then
                                                                Month := Month::NOVEMBER else
                                                                if months = 12 then Month := Month::DECEMBER;
                end;
                Modify;
            end;
        }
        field(4; Kilometers; Decimal)
        {
        }
        field(5; Engine; Boolean)
        {
        }
        field(6; "Rear Exle"; Boolean)
        {
        }
        field(7; "Gear Box"; Boolean)
        {
        }
        field(8; "Front Exle"; Boolean)
        {
        }
        field(9; "Transfer Box"; Boolean)
        {
        }
        field(10; "Front Hubs"; Boolean)
        {
        }
        field(11; "Chasis Lubrication"; Boolean)
        {
        }
        field(12; "Details in log Book"; Text[50])
        {
        }
        field(20; Month; Option)
        {
            OptionMembers = " ",JANUARY,FEBRUARY,MARCH,APRIL,MAY,JUNE,JULY,AUGUST,SEPTEMBER,OCTOBER,NOVEMBER,DECEMBER;
        }
        field(21; Year; Option)
        {
            OptionMembers = " ","2010","2011","2012","2013","2014","2015","2016","2017","2018","2019","2020","2021","2022","2023","2024","2025","2026","2027","2028","2029","2030","2031","2032","2033","2034","2035","2036","2037","2038","2039","2040","2041","2042","2043","2044","2045","2046","2047","2048","2049","2050","2051","2052","2053","2054","2055","2056","2057","2058","2059","2060";
        }
    }

    keys
    {
        key(Key1; "Oiling Id", "Reg. No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Oiling Date" := Today;
    end;

    var
        months: Integer;
}

