page 54913 "HMS-Radiology History List"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HMS-Radiology Form Header";
    SourceTableView = WHERE(Status = FILTER(= Completed | = Forwarded));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Radiology No."; Rec."Radiology No.")
                {
                    ApplicationArea = All;
                }
                field("Link No."; Rec."Link No.")
                {
                    ApplicationArea = All;
                }
                field("Link Type"; Rec."Link Type")
                {
                    ApplicationArea = All;
                }
                field("Radiology Date"; Rec."Radiology Date")
                {
                    ApplicationArea = All;
                }
                field("Radiology Time"; Rec."Radiology Time")
                {
                    ApplicationArea = All;
                }
                field("Radiology Area"; Rec."Radiology Area")
                {
                    ApplicationArea = All;
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("&Request Lines")
            {
                Caption = '&Request Lines';
                Image = LineDescription;
                Promoted = true;
                RunObject = Page "HMS-Radiology Req. Hist. Lines";
                RunPageLink = "Radiology no." = FIELD("Radiology No.");
                ApplicationArea = All;
            }
        }
    }
}

