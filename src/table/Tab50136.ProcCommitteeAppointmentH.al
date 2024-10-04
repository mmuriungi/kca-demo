table 50136 "Proc-Committee Appointment H"
{
    DrillDownPageId = "Proc-Committee List";
    Caption = 'Proc-Committee Appointment H';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Ref No"; Code[20])
        {
            Caption = 'Ref No';
            Editable = false;
        }
        field(2; "Date"; DateTime)
        {
            Editable = false;
            Caption = 'Date';
        }
        field(3; "Tender/Quote No"; Code[50])
        {
            Caption = 'Tender/RFQ No';
            TableRelation = "PROC-Purchase Quote Header"."No." where("Procurement methods" = field("Procurement Method"), Status = filter(Released));
            trigger OnValidate()
            begin
                if "Procurement Method" = "Procurement Method"::" " then Error('First choose the procurement method!');
            end;
        }
        field(4; Description; Text[2048])
        {
            Caption = 'Description';
        }
        field(5; "Created By"; Code[50])
        {
            Editable = false;
            Caption = 'Created By';
        }
        field(6; Status; Option)
        {
            //Editable=false;
            Caption = 'Status';
            OptionMembers = Open,"Pending Approval",Approved;
            trigger OnValidate()
            begin
                if Status = Status::Approved then begin
                    Date := CurrentDateTime;
                    Modify();
                end;

            end;
        }
        field(7; "Responsibility Centre"; Code[50])
        {
            Caption = 'Responsibility Centre';
            TableRelation = "Responsibility Center".Code;
        }
        field(8; "Procurement Method"; Enum "Proc-Procurement Methods")
        {

        }
        field(9; "To"; Text[250])
        {
            TableRelation = "HRM-Jobs"."Job ID";
            trigger OnValidate()
            begin
                Hrmjobs.Reset();
                Hrmjobs.SetRange("Job ID", "To");
                if Hrmjobs.Find('-') then
                    "To" := Hrmjobs."Job Title";
            end;

        }



    }
    keys
    {
        key(PK; "Ref No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Ref No", Description)
        {
        }
    }
    trigger OnInsert()
    begin

        if "Ref No" = '' then
            Purchasespaybles.reset();
        Purchasespaybles.SetRange("Doc Type", Purchasespaybles."Doc Type"::"Appointment Doc");
        if Purchasespaybles.Find('-') then begin
            Newrefcode := Noseriesmgt.GetNextNo(Purchasespaybles."Number Series", Today, true);
            "Ref No" := Purchasespaybles."Institution Code" + '/' + Purchasespaybles.FY + '/' + Purchasespaybles.Prefix + '-' + Newrefcode;
            "Created By" := UserId;
            Date := CurrentDateTime;
        end;

    end;

    Procedure UpdateCommitteeMembership()
    begin
        Commiteemembership.Reset();
        Commiteemembership.SetRange("No.", rec."Tender/Quote No");
        if Commiteemembership.Find('-') then Commiteemembership.DeleteAll();
        rec.Reset();
        rec.SetRange("Ref No", rec."Ref No");
        if rec.Find('-') then begin
            Appointendmembers.Reset();
            Appointendmembers.SetRange("Ref No", rec."Ref No");
            if Appointendmembers.Find('-') then
                repeat
                    Commiteemembership.Reset();
                    Commiteemembership.SetRange("No.", rec."Tender/Quote No");
                    Commiteemembership.SetRange("Staff No.", Appointendmembers."Member No");
                    Commiteemembership.SetRange("Committee Type", Appointendmembers.Committee);
                    Commiteemembership.SetFilter("Entry No.", '<>%1', 0);
                    if not Commiteemembership.Find('-') then begin
                        Commiteemembership.Init();
                        Commiteemembership."Entry No." := Commiteemembership."Entry No." + 1;
                        Commiteemembership."Staff No." := Appointendmembers."Member No";
                        Commiteemembership.Name := Appointendmembers.Name;
                        Commiteemembership."Member Type" := Appointendmembers."Member Type";
                        Commiteemembership.Email := Appointendmembers.Email;
                        Commiteemembership."Telephone No." := Appointendmembers."Phone No";
                        Commiteemembership."No." := rec."Tender/Quote No";
                        Commiteemembership."Committee Type" := Appointendmembers.Committee;
                        Commiteemembership.Insert();
                    end else begin
                        Commiteemembership."Staff No." := Appointendmembers."Member No";
                        Commiteemembership.Name := Appointendmembers.Name;
                        Commiteemembership."Member Type" := Appointendmembers."Member Type";
                        Commiteemembership.Email := Appointendmembers.Email;
                        Commiteemembership."Telephone No." := Appointendmembers."Phone No";
                        Commiteemembership."No." := rec."Tender/Quote No";
                        Commiteemembership."Committee Type" := Appointendmembers.Committee;
                        Commiteemembership.Modify();
                    end;
                until Appointendmembers.Next() = 0;

        end;
    end;



    var
        Approvalentry: Record "Approval Entry";
        Appointendmembers: Record "Proc-Committee Members";
        Commiteemembership: Record "Proc-Committee Membership";
        Newrefcode: Code[20];
        Purchasespaybles: Record "Proc Number Setups";
        Noseriesmgt: Codeunit NoSeriesManagement;
        Hrmjobs: Record "HRM-Jobs";
}
