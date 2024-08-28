page 51430 "FLT-Work Ticket Lines"
{
    PageType = ListPart;
    SourceTable = "FLT-Daily Work Ticket Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Driver No."; Rec."Driver No.")
                {
                    ApplicationArea = All;
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ApplicationArea = All;
                }
                field("Departure From"; Rec."Departure From")
                {
                    ApplicationArea = All;
                }
                field(Destination; Rec.Destination)
                {
                    ApplicationArea = All;
                }
                field("Purpose of the Journey"; rec."Purpose of the Journey")
                {
                    ApplicationArea = All;
                }
                field("Work Date"; Rec."Work Date")
                {
                    ApplicationArea = All;
                }
                field("Authorizing Officer No"; Rec."Authorizing Officer No")
                {
                    ApplicationArea = All;
                }
                field("Authorizing Officer Name"; Rec."Authorizing Officer Name")
                {
                    ApplicationArea = All;
                }
                field("Time Out"; Rec."Time Out")
                {
                    ApplicationArea = All;
                }

                field("Start Milleage"; Rec."Start Milleage")
                {
                    ApplicationArea = All;
                }

                field("Reg. No."; Rec."Reg. No.")
                {
                    ApplicationArea = All;
                }
                field("Time In"; Rec."Time In")
                {
                    ApplicationArea = All;
                }
                field("End Milleage"; Rec."End Milleage")
                {
                    ApplicationArea = All;
                }
                field("Kilometers Covered2"; rec."Kilometers Covered2")
                {
                    ApplicationArea = All;
                }
                field("Voucher No."; Rec."Voucher No.")
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

