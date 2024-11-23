page 52178826 "Tender Bidder Fin Reqs"
{
    PageType = List;
    SourceTable = "Tender Bidder Fin Reqs";
    InsertAllowed = false;
    //DeleteAllowed = false;
    layout
    {
        area(content)
        {
            repeater(general)
            {

                field("Tender No."; Rec."Tender No.")
                {
                    ToolTip = 'Specifies the value of the Tender No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bid No."; Rec."Bid No.")
                {
                    ToolTip = 'Specifies the value of the Bid No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bidder No."; Rec."Bidder No.")
                {
                    ToolTip = 'Specifies the value of the Bidder No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ToolTip = 'Specifies the value of the Description 2 field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Budgeted Value"; Rec."Budgeted Value")
                {
                    ToolTip = 'Specifies the value of the Budgeted Value field.';
                    ApplicationArea = All;
                }
                field("Quoted Amount"; Rec."Quoted Amount")
                {
                    ToolTip = 'Specifies the value of the Quoted Amount field.';
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                    ApplicationArea = All;
                }
                field("Total Bid Amount"; Rec."Total Bid Amount")
                {
                    ToolTip = 'Specifies the value of the Total Bid Amount field.';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }


            }
        }
    }
}