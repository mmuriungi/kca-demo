enum 50021 "CRM Interaction Types"
{
    Extensible = true;

    value(0; " ")
    {
    }
    value(1; "Service Request")
    {
        Caption = 'Service Request';
    }
    value(2; Enquiry)
    {
        Caption = 'Enquiry';
    }
    value(3; Feedback)
    {
        Caption = 'Feedback';
    }
    // value(4; "Disciplinary")
    // {
    //     Caption = 'Disciplinary Complaint';
    // }
    value(5; Submissions)
    {
        Caption = 'Submissions';
    }
    value(6; "Purchase of Tender")
    {
        Caption = 'Submission of Tender';
    }
    value(7; "Records Update")
    {
        Caption = 'Records Update';
    }
    value(8; "Debt Reconciliation")
    {
        Caption = 'Procurement Issue';
    }
    value(9; "Non-Disciplinary Complaint")
    {
        Caption = 'Complaint';
    }
}
