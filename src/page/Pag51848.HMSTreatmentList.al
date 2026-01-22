page 51848 "HMS-Treatment List"
{
    CardPageID = "HMS-Treatment Form Header";
    PageType = List;
    SourceTable = "HMS-Treatment Form Header";
    SourceTableView = WHERE(Status = FILTER(<> Completed));

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                Editable = false;
                field("Treatment No."; Rec."Treatment No.")
                {
                    ApplicationArea = All;
                }
                field("Treatment By"; Rec."Doctor ID")
                {
                    Caption = ' Under Treatment By';
                    ApplicationArea = All;
                }
                field("Treatment Type"; Rec."Treatment Type")
                {
                    ApplicationArea = All;
                }
                field("Treatment Date"; Rec."Treatment Date")
                {
                    ApplicationArea = All;
                }
                field("Treatment Time"; Rec."Treatment Time")
                {
                    ApplicationArea = All;
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = All;
                }
                field("Patient Name"; Rec."Patient Name")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Observation remarks Remarks"; Rec."Treatment Remarks")
                {
                    ApplicationArea = All;
                }
                field(Location; rec.Location)
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
            action(History)
            {
                Caption = 'History';
                RunObject = Page "HMS-Treatment History List";
                RunPageLink = "Patient No." = FIELD("Patient No.");
                ApplicationArea = All;
            }
        }
    }

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;
}

