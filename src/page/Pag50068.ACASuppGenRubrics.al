page 50068 "ACA-Supp. Gen. Rubrics"
{
    ApplicationArea = All;
    Caption = 'ACA-Supp. Gen. Rubrics';
    PageType = List;
    SourceTable = "ACA-Supp. Results Status";
    SourceTableView = where("Special Programme Class" = filter(General));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Transcript Remarks"; Rec."Transcript Remarks")
                {
                    ApplicationArea = Basic;
                }
                field("Final Year Comment"; Rec."Final Year Comment")
                {
                    ApplicationArea = Basic;
                }
                field("Manual Status Processing"; Rec."Manual Status Processing")
                {
                    ApplicationArea = Basic;
                }
                field("Order No"; Rec."Order No")
                {
                    ApplicationArea = Basic;
                }
                field("Status Msg1"; Rec."Status Msg1")
                {
                    ApplicationArea = Basic;
                }
                field("IncludeVariable 1"; Rec."IncludeVariable 1")
                {
                    ApplicationArea = Basic;
                }
                field("Status Msg2"; Rec."Status Msg2")
                {
                    ApplicationArea = Basic;
                }
                field("IncludeVariable 2"; Rec."IncludeVariable 2")
                {
                    ApplicationArea = Basic;
                }
                field("Status Msg3"; Rec."Status Msg3")
                {
                    ApplicationArea = Basic;
                }
                field("IncludeVariable 3"; Rec."IncludeVariable 3")
                {
                    ApplicationArea = Basic;
                }
                field("Status Msg4"; Rec."Status Msg4")
                {
                    ApplicationArea = Basic;
                }
                field("IncludeVariable 4"; Rec."IncludeVariable 4")
                {
                    ApplicationArea = Basic;
                }
                field("Status Msg5"; Rec."Status Msg5")
                {
                    ApplicationArea = Basic;
                }
                field("IncludeVariable 5"; Rec."IncludeVariable 5")
                {
                    ApplicationArea = Basic;
                }
                field("Status Msg6"; Rec."Status Msg6")
                {
                    ApplicationArea = Basic;
                }
                field("IncludeVariable 6"; Rec."IncludeVariable 6")
                {
                    ApplicationArea = Basic;
                }
                field("1st Year Grad. Comments"; Rec."1st Year Grad. Comments")
                {
                    ApplicationArea = Basic;
                }
                field("2nd Year Grad. Comments"; Rec."2nd Year Grad. Comments")
                {
                    ApplicationArea = Basic;
                }
                field("3rd Year Grad. Comments"; Rec."3rd Year Grad. Comments")
                {
                    ApplicationArea = Basic;
                }
                field("4th Year Grad. Comments"; Rec."4th Year Grad. Comments")
                {
                    ApplicationArea = Basic;
                }
                field("5th Year Grad. Comments"; Rec."5th Year Grad. Comments")
                {
                    ApplicationArea = Basic;
                }
                field("6th Year Grad. Comments"; Rec."6th Year Grad. Comments")
                {
                    ApplicationArea = Basic;
                }
                field("7th Year Grad. Comments"; Rec."7th Year Grad. Comments")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Units Failed"; Rec."Minimum Units Failed")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Units Failed"; Rec."Maximum Units Failed")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Summary Page Caption"; Rec."Summary Page Caption")
                {
                    ApplicationArea = Basic;
                }
                field("Include Failed Units Headers"; Rec."Include Failed Units Headers")
                {
                    ApplicationArea = Basic;
                }
                field("Min/Max Based on"; Rec."Min/Max Based on")
                {
                    ApplicationArea = Basic;
                }
                field("Include Academic Year Caption"; Rec."Include Academic Year Caption")
                {
                    ApplicationArea = Basic;
                }
                field(Pass; Rec.Pass)
                {
                    ApplicationArea = Basic;
                }
                field("Include CF% Fail"; Rec."Include CF% Fail")
                {
                    ApplicationArea = Basic;
                }
                field("Skip Supp Generation"; Rec."Skip Supp Generation")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Special Programme Class" := Rec."special programme class"::General;
    end;
}

