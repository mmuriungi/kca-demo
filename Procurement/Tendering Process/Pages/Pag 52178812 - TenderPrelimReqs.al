page 52178812 "Tender Prelim Reqs"
{
    PageType = List;
    SourceTable = "Tender Prelim Reqs";

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Tender No."; Rec."Tender No.")
                {
                    ToolTip = 'Specifies the value of the Tender No. field.';
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
            }
        }
    }
}