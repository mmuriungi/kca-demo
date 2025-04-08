table 50126 "Aca-AcademicYear_Buffer"
{
    Caption = 'Aca-AcademicYear_Buffer';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; User_Id; Code[50])
        {
            Caption = 'User_Id';
        }
        field(2; Academic_Year; Code[50])
        {
            Caption = 'Academic_Year';
        }
    }
    keys
    {
        key(PK; User_Id,Academic_Year)
        {
            Clustered = true;
        }
    }
}
