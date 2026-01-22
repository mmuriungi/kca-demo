table 51387 "ACA-Exam Proc. Active users"
{
    Caption = 'ACA-Exam Proc. Active users';
    DataClassification = ToBeClassified;

    fields
    {

        /*
        Enabled	Field No.	Field Name	Data Type	Length	Description
Yes	1	Token ID	Integer		
Yes	2	Processing Users	Code	20	
Yes	3	User is Active	Boolean		
        */
        field(1; "Token ID"; Integer)
        {
            Caption = 'Token ID';
        }
        field(2; "Processing Users"; Code[20])
        {
            Caption = 'Processing Users';
        }
        field(3; "User is Active"; Boolean)
        {
            Caption = 'User is Active';
        }
    }
    keys
    {
        key(PK; "Token ID")
        {
            Clustered = true;
        }
    }
}
