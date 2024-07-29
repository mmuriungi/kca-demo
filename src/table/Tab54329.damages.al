table 54329 damages
{
    Caption = 'damages';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "damage number"; Code[56])
        {
            Caption = 'damage number';
        }
        field(2; "Damage Description"; Code[100])
        {
            Caption = 'Damage Description';
        }
        field(3; "student  Number"; Code[20])
        {
            Caption = 'student  Number';
            TableRelation = Customer."No.";

            trigger OnValidate()
            var
                Cust: Record Customer;
            begin
                Cust.Reset();
                if Cust.Get("student  Number") then begin
                    rec."student Name " := Cust.Name;
                    rec."student Email" := Cust."University Email";
                    rec."student phone number" := Cust."Phone No.";
                    Modify();
                end;
            end;
        }
        field(4; "student Name "; Code[30])
        {
            Caption = 'student Name ';
        }
        field(5; "student Email"; Code[50])
        {
            Caption = 'student Email';
        }
        field(6; "student phone number"; Code[50])
        {
            Caption = 'student phone number';

        }
        field(11; status; Option)
        {
            OptionMembers = "",initiated,dvc,billed,cancel,finance,closed;
            DataClassification = ToBeClassified;
        }
        field(7; "item name "; Code[40])
        {
            Caption = 'item name ';
        }
        field(8; "damage cost "; Code[40])
        {
            Caption = 'damage cost ';
        }
        field(9; "dvc comment "; Code[40])
        {
            Caption = 'dvc comment ';
        }
        field(10; "finance comment "; Code[40])
        {
            Caption = 'finance comment ';
        }
    }
    keys
    {
        key(PK; "damage number")
        {
            Clustered = true;
        }
    }
}
