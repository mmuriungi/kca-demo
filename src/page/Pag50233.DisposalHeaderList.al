page 50233 "Disposal Header List"
{
    CardPageID = "Disposal Header";
    Editable = false;
    PageType = List;
    SourceTable = "Disposal Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field(Desciption; Rec.Desciption)
                {
                }
                field("Disposal Method"; Rec."Disposal Method")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Disposal Status"; Rec."Disposal Status")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("No series"; Rec."No series")
                {
                }
                field("Ref No"; Rec."Ref No")
                {
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                }
                field(Disposed; Rec.Disposed)
                {
                }
                field("Shortcut dimension 2 code"; Rec."Shortcut dimension 2 code")
                {
                    Caption = 'County Code';
                }
                field("Shortcut dimension 1 code"; Rec."Shortcut dimension 1 code")
                {
                    Caption = 'Department Code';
                }
                field("Disposal Period"; Rec."Disposal Period")
                {
                }
            }
        }
    }

    actions
    {
    }
}

