page 54289 "FLT-Fuel Pymnt Batch List"
{
    CardPageID = "FLT-Fuel Pymnt Batch";
    PageType = List;
    SourceTable = "FLT-Fuel Payment Batch";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Batch No"; Rec."Batch No")
                {
                    ApplicationArea = All;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                }
                field("Created by"; Rec."Created by")
                {
                    ApplicationArea = All;
                }
                field("Vendor No"; Rec."Vendor No")
                {
                    ApplicationArea = All;
                }
                field("Date Closed"; Rec."Date Closed")
                {
                    ApplicationArea = All;
                }
                field("Closed By"; Rec."Closed By")
                {
                    ApplicationArea = All;
                }
                field("Total Payable"; Rec."Total Payable")
                {
                    ApplicationArea = All;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                }
                field(From; Rec.From)
                {
                    ApplicationArea = All;
                }
                field(DTo; Rec.DTo)
                {
                    ApplicationArea = All;
                }
                field(Invoiced; Rec.Invoiced)
                {
                    ApplicationArea = All;
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("Invoiced By"; Rec."Invoiced By")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

