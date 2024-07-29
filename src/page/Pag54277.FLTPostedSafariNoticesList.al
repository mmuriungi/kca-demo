page 54277 "FLT-Posted Safari Notices List"
{
    CardPageID = "FLT-Posted Safari Notices";
    PageType = List;
    SourceTable = "FLT-Safari Notice";
    SourceTableView = WHERE(Status = FILTER(Submitted));

    layout
    {
        area(content)
        {
            repeater("Employee Safari Notices")
            {
                field("Safari No."; Rec."Safari No.")
                {
                    ApplicationArea = All;
                }
                field("Proposed By"; Rec."Proposed By")
                {
                    ApplicationArea = All;
                }
                field("Proposer Name"; Rec."Proposer Name")
                {
                    ApplicationArea = All;
                }
                field("Proposer Department"; Rec."Proposer Department")
                {
                    ApplicationArea = All;
                }
                field("Proposed Date"; Rec."Proposed Date")
                {
                    ApplicationArea = All;
                }
                field("Officer Going"; Rec."Officer Going")
                {
                    ApplicationArea = All;
                }
                field("Officer Going Name"; Rec."Officer Going Name")
                {
                    ApplicationArea = All;
                }
                field("Officer Designation"; Rec."Officer Designation")
                {
                    ApplicationArea = All;
                }
                field("Purpose Of Visit"; Rec."Purpose Of Visit")
                {
                    ApplicationArea = All;
                }
                field("Place to Visit"; Rec."Place to Visit")
                {
                    ApplicationArea = All;
                }
                field("Departure Date"; Rec."Departure Date")
                {
                    ApplicationArea = All;
                }
                field("Return Date"; Rec."Return Date")
                {
                    ApplicationArea = All;
                }
                field("Departure Mileage"; Rec."Departure Mileage")
                {
                    ApplicationArea = All;
                }
                field("Reg. No"; Rec."Reg. No")
                {
                    ApplicationArea = All;
                }
                field(Make; Rec.Make)
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Estimated Cost of Safari"; Rec."Estimated Cost of Safari")
                {
                    ApplicationArea = All;
                }
                field(Dept; Rec.Dept)
                {
                    ApplicationArea = All;
                }
                field("T.O. Name"; Rec."T.O. Name")
                {
                    ApplicationArea = All;
                }
                field("T.O. Approval Date"; Rec."T.O. Approval Date")
                {
                    ApplicationArea = All;
                }
                field(Makes; Rec.Makes)
                {
                    ApplicationArea = All;
                }
                field(Model; Rec.Model)
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

