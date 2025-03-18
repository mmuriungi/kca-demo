table 50122 "Exam First Day Units"
{
    Caption = 'Exam First Day Units';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Unit; Code[25])
        {
            Caption = 'Unit';
            TableRelation = "ACA-Units/Subjects";
            trigger OnValidate()
            var
                UnitSubj: Record "ACA-Units/Subjects";
            begin
                UnitSubj.RESET;
                UnitSubj.SETRANGE(UnitSubj.Code, Unit);
                IF UnitSubj.FIND('-') THEN BEGIN
                    Description := UnitSubj.Desription;
                END;
            end;
        }
        field(2; Description; Text[150])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; Unit)
        {
            Clustered = true;
        }
    }
}
