table 50909 "Cafeteria Menu"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Meal Code"; code[20])
        {
            Caption = 'Meal Code';
            DataClassification = ToBeClassified;
        }

        field(2; "Meal Description"; Text[150])
        {
            Caption = 'Meal Description';
            DataClassification = ToBeClassified;
        }

        field(3; "Meal Category"; option)
        {
            Caption = 'Meal Category';
            OptionCaption = 'Normal,Meal Booking';
            OptionMembers = "Normal","Meal Booking";
            DataClassification = ToBeClassified;
        }

        field(4; "Active"; Boolean)
        {
            Caption = 'Active';
            DataClassification = ToBeClassified;
        }

        field(5; "Quantity on Hand"; decimal)
        {
            Caption = 'Quantity on Hand';
            DataClassification = ToBeClassified;
        }

        field(6; "Staff Price"; Decimal)
        {
            Caption = 'Staff Price';
            DataClassification = ToBeClassified;
        }

        field(7; "Students Price"; Integer)
        {
            Caption = 'Students Price';
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "Meal Code")
        {
            Clustered = true;
        }
    }

}