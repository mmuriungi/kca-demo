table 50182 "Auditee Team"
{
    Caption = 'Auditee Team';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
            TableRelation = "Audit Header"."No.";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Member ID"; Code[20])
        {
            Caption = 'Member ID';
            DataClassification = ToBeClassified;
            TableRelation = Employee;
            
            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                if Employee.Get("Member ID") then
                    "Member Name" := Employee."First Name" + ' ' + Employee."Last Name";
            end;
        }
        field(4; "Member Name"; Text[100])
        {
            Caption = 'Member Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Position"; Text[50])
        {
            Caption = 'Position';
            DataClassification = ToBeClassified;
        }
        field(6; "Department"; Code[30])
        {
            Caption = 'Department';
            DataClassification = ToBeClassified;
        }
        field(7; "Email"; Text[80])
        {
            Caption = 'Email';
            DataClassification = ToBeClassified;
        }
        field(8; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = ToBeClassified;
        }
    }
    
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
    
    trigger OnInsert()
    begin
        if "Line No." = 0 then
            "Line No." := GetNextLineNo();
    end;
    
    local procedure GetNextLineNo(): Integer
    var
        AuditeeTeam: Record "Auditee Team";
    begin
        AuditeeTeam.Reset();
        AuditeeTeam.SetRange("Document No.", "Document No.");
        if AuditeeTeam.FindLast() then
            exit(AuditeeTeam."Line No." + 10000)
        else
            exit(10000);
    end;
}
