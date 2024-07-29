table 54320 "maintenance request lines"
{
    Caption = 'maintenance request lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[60])
        {
            Caption = 'No.';
        }
        field(2; "maintenance Requests"; Code[50])
        {
            Caption = 'maintenance Requests';
            TableRelation = "maintenance Request list2"." Maintenance Descriptions";
        }
        field(3; description; Code[100])
        {
            Caption = 'description';
        }
        field(4; IsRepair; Boolean)
        {
            Caption = 'IsRepair';
        }
        field(5; IsMaintenance; Boolean)
        {
            Caption = 'IsMaintenance';
        }
        field(6; AssignedMo; Code[40])
        {
            DataClassification = ToBeClassified;
            Caption = 'No.';
            TableRelation = "HRM-Employee C"."No."; //where("Maint Officer" = filter(true));
            trigger OnValidate()
            var
                Employee: Record "HRM-Employee C";
            begin

                Employee.Reset();
                if Employee.Get(AssignedMo) then begin
                    Name := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    email := Employee."E-Mail";

                end;
            end;


        }
        field(7; Name; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; email; code[60])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Estimated Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; timeline; Date)
        {
            DataClassification = ToBeClassified;
        }


    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
