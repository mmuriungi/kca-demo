<<<<<<< HEAD
table 51392 "Bank Rec. Archive Header"
=======
table 50178 "Bank Rec. Archive Header"
>>>>>>> 34f38dec1936c09d734c210f8c578c2203eaec4a
{
    Caption = 'Bank Rec. Archive Header';
    DataClassification = ToBeClassified;



    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(10; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';
            TableRelation = "Bank Account";
            DataClassification = CustomerContent;
        }
        field(20; "Statement No."; Code[20])
        {
            Caption = 'Statement No.';
            DataClassification = CustomerContent;
        }
        field(30; "Statement Date"; Date)
        {
            Caption = 'Statement Date';
            DataClassification = CustomerContent;
        }
        field(40; "Total Statement Amount"; Decimal)
        {
            Caption = 'Total Statement Amount';
            DataClassification = CustomerContent;
        }
        field(50; "Total Difference"; Decimal)
        {
            Caption = 'Total Difference';
            DataClassification = CustomerContent;
        }
        field(60; "User ID"; Code[50])
        {
            Caption = 'User ID';
          //  TableRelation = user
            DataClassification = EndUserIdentifiableInformation;
        }
        field(70; "Archive Date"; Date)
        {
            Caption = 'Archive Date';
            DataClassification = CustomerContent;
        }
        //"Statement Ending Balance"
        field(80; "Statement Ending Balance"; Decimal)
        {
            Caption = 'Statement Ending Balance';
            DataClassification = CustomerContent;
        }
        //"Statement Starting Balance"
        field(90; "Statement Starting Balance"; Decimal)
        {
            Caption = 'Statement Starting Balance';
            DataClassification = CustomerContent;
        }
        //Difference
        field(100; "Difference"; Decimal)
        {
            Caption = 'Difference';
            DataClassification = CustomerContent;
        }
        //Applied Amount
        field(110; "Applied Amount"; Decimal)
        {
            Caption = 'Applied Amount';
            DataClassification = CustomerContent;
        }
        field(101; "Bank Name"; Text[250])
        {
            Caption = 'Bank Name';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(SK1; "Bank Account No.", "Statement Date")
        {
            SumIndexFields = "Total Statement Amount", "Total Difference";
        }
    }
}
