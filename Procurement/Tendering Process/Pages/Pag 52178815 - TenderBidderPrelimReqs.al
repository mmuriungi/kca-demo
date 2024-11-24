page 52178815 "Tender Bidder Prelim Reqs"
{
    SourceTable = "Tender Bidder Prelim Reqs";
    PageType = List;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(general)
            {
                field("Tender No."; Rec."Tender No.")
                {
                    ToolTip = 'Specifies the value of the Tender No. field.';
                    ApplicationArea = All;
                }
                field("Bid No."; Rec."Bid No.")
                {
                    ToolTip = 'Specifies the value of the Bid No. field.';
                    ApplicationArea = All;
                }
                field("Bidder No."; Rec."Bidder No.")
                {
                    ToolTip = 'Specifies the value of the Bidder No. field.';
                    ApplicationArea = All;
                }
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ToolTip = 'Specifies the value of the Description 2 field.';
                    ApplicationArea = All;
                }
                field("Requirements Met?"; Rec."Requirements Met?")
                {
                    ToolTip = 'Specifies the value of the Requirements Met? field.';
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                    ApplicationArea = All;
                }
                field("Employee no"; Rec."Employee no")
                {
                    ToolTip = 'Specifies the value of the Employee no field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("User Name"; Rec."User Name")
                {
                    ToolTip = 'Specifies the value of the User Name field.';
                    ApplicationArea = All;
                    Editable = false;
                }

            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetFilter("User Name", USERID);
    end;
}