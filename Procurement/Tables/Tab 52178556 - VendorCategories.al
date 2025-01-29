/// <summary>
/// Table Vendor Categories (ID 52178532).
/// </summary>
table 52178556 "Vendor Categories"
{
    Caption = 'Vendor Categories';
    DataClassification = ToBeClassified;

    fields
    {
        
        field(1; "Code"; Code[50])
        {
            Caption = 'Category Code';
            //DataClassification = ToBeClassified;
            TableRelation = "Proc-Goods Clasiffication".Code;

            trigger OnValidate()
            var
                chrge: Record "Proc-Goods Clasiffication";
            begin
                chrge.Reset();
                chrge.SetRange("Code", "Code");
                if chrge.Find('-') then begin
                    "Description" := chrge.Description;
                end;
            end;
        }
        field(2; Description; Text[500])
        {
            Caption = 'Description';
            //DataClassification = ToBeClassified;
        }
        field(3; "Preq Year"; Code[50])
        {
            //DataClassification = ToBeClassified;
            TableRelation = "Proc-Prequalification Years"."Preq. Year";
        }
    }
    keys
    {
        key(PK; "Code","Preq Year")
        {
            Clustered = true;
        }
    }
}
