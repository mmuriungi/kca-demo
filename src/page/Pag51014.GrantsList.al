page 51014 "Grants List"
{
    Caption = 'Grants List';
    PageType = List;
    CardPageId = "ACA-Grant";
    SourceTable = "ACA-Grants";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Awarding agency"; Rec."Awarding agency")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Awarding agency field.';
                }
                field("Financial Year"; Rec."Financial Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Financial Year field.';
                }
                field("Grant Timeframe(In Months)"; Rec."Grant Timeframe(In Months)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Grant Timeframe(In Months) field.';
                }
                field("Total Amount Awarded"; Rec."Total Amount Awarded")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Amount Awarded field.';
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remaining Amount field.';
                }
                field("Store Title"; Rec."Store Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Store Title field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }

            }
        }
    }
}
