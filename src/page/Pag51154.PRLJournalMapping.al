page 51154 "PRL-Journal Mapping"
{
    PageType = Card;
    SourceTable = "PRL-Journal Trans Mapping";

    layout
    {
        area(content)
        {
            field("Transaction Code"; Rec."Transaction Code")
            {
                Editable = false;
            }
            field("GL Navision"; Rec."GL Navision")
            {
                Editable = true;
            }
            field("GL Others"; Rec."GL Others")
            {
                Caption = 'GL (Other FMS)';
            }
            field("Append StaffCode"; Rec."Append StaffCode")
            {
            }
            field("Amount (Dr/Cr)"; Rec."Amount (Dr/Cr)")
            {
            }
            field(Analysis0; Rec.Analysis0)
            {
                Caption = 'Analysis 0';
            }
            field(Analysis1; Rec.Analysis1)
            {
                Caption = 'Analysis 1';
            }
            field(Analysis2; Rec.Analysis2)
            {
                Caption = 'Analysis 2';
            }
            field(Analysis3; Rec.Analysis3)
            {
                Caption = 'Analysis 3';
            }
            field(Analysis4; Rec.Analysis4)
            {
                Caption = 'Analysis 4';
            }
            field(Analysis5; Rec.Analysis5)
            {
                Caption = 'Analysis 5';
            }
        }
    }

    actions
    {
    }
}

