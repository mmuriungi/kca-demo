page 50457 "HRM-Activity Participants SF"
{
    Caption = 'Activity Participants';
    PageType = Listpart;
    SaveValues = true;
    SourceTable = "HRM-Activity Participants";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field(Notified; Rec.Notified)
                {
                    Editable = true;
                }
                field(Participant; Rec.Participant)
                {
                }
                field("Partipant Name"; Rec."Partipant Name")
                {
                }
                field(Contribution; Rec.Contribution)
                {
                }
                field("Email Message"; Rec."Email Message")
                {
                }
            }
        }
    }

    actions
    {
    }
}

