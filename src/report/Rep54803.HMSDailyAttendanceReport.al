report 54803 "HMS Daily Attendance Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSDailyAttendanceReport.rdl';

    dataset
    {
        dataitem(DataItem5444; 2000000026)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = FILTER(1 .. 31));
            RequestFilterFields = Number;
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Records_of_daily_attendance_for_the_month_of____FORMAT_Month_; 'Records of daily attendance for the month of ' + FORMAT(Month))
            {
            }
            column(stfMsn; stfMsn)
            {
            }
            column(dtDate; dtDate)
            {
            }
            column(dpnMsn; dpnMsn)
            {
            }
            column(stfKsm; stfKsm)
            {
            }
            column(stuMsn; stuMsn)
            {
            }
            column(dpnKsm; dpnKsm)
            {
            }
            column(othMsn; othMsn)
            {
            }
            column(stuKsm; stuKsm)
            {
            }
            column(stfMsn___dpnMsn___stuMsn___othMsn; stfMsn + dpnMsn + stuMsn + othMsn)
            {
            }
            column(othKsm; othKsm)
            {
            }
            column(stfKsm___dpnKsm___stuKsm___othKsm; stfKsm + dpnKsm + stuKsm + othKsm)
            {
            }
            column(GstfMsn; GstfMsn)
            {
            }
            column(GstfKsm; GstfKsm)
            {
            }
            column(GdpnMsn; GdpnMsn)
            {
            }
            column(GdpnKsm; GdpnKsm)
            {
            }
            column(GstuMsn; GstuMsn)
            {
            }
            column(GstuKsm; GstuKsm)
            {
            }
            column(GothMsn; GothMsn)
            {
            }
            column(GstuKsm_Control1102760067; GstuKsm)
            {
            }
            column(GstfMsn___GdpnMsn___GstuMsn___GothMsn; GstfMsn + GdpnMsn + GstuMsn + GothMsn)
            {
            }
            column(GstfKsm___GdpnKsm___GstuKsm___GothKsm; GstfKsm + GdpnKsm + GstuKsm + GothKsm)
            {
            }
            column(USERID; USERID)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(GstfMsn___GdpnMsn___GstuMsn___GothMsn__UpperLimit; (GstfMsn + GdpnMsn + GstuMsn + GothMsn) / UpperLimit)
            {
            }
            column(GstfKsm___GdpnKsm___GstuKsm___GothKsm__UpperLimit; (GstfKsm + GdpnKsm + GstuKsm + GothKsm) / UpperLimit)
            {
            }
            column(GstfMsn___GdpnMsn___GstuMsn___GothMsn__GstfKsm___GdpnKsm___GstuKsm___GothKsm__UpperLimit; (GstfMsn + GdpnMsn + GstuMsn + GothMsn + GstfKsm + GdpnKsm + GstuKsm + GothKsm) / UpperLimit)
            {
            }
            column(HEALTH_SERVICESCaption; HEALTH_SERVICESCaptionLbl)
            {
            }
            column(DATECaption; DATECaptionLbl)
            {
            }
            column(MAINCaption; MAINCaptionLbl)
            {
            }
            column(OTHERCaption; OTHERCaptionLbl)
            {
            }
            column(MAINCaption_Control1102760007; MAINCaption_Control1102760007Lbl)
            {
            }
            column(OTHERCaption_Control1102760008; OTHERCaption_Control1102760008Lbl)
            {
            }
            column(MAINCaption_Control1102760009; MAINCaption_Control1102760009Lbl)
            {
            }
            column(OTHERCaption_Control1102760010; OTHERCaption_Control1102760010Lbl)
            {
            }
            column(MAINCaption_Control1102760011; MAINCaption_Control1102760011Lbl)
            {
            }
            column(OTHERCaption_Control1102760012; OTHERCaption_Control1102760012Lbl)
            {
            }
            column(MAINCaption_Control1102760013; MAINCaption_Control1102760013Lbl)
            {
            }
            column(MAINCaption_Control1102760014; MAINCaption_Control1102760014Lbl)
            {
            }
            column(STAFFCaption; STAFFCaptionLbl)
            {
            }
            column(DEPENDANTCaption; DEPENDANTCaptionLbl)
            {
            }
            column(STUDENTCaption; STUDENTCaptionLbl)
            {
            }
            column(OTHERSCaption; OTHERSCaptionLbl)
            {
            }
            column(TOTALCaption; TOTALCaptionLbl)
            {
            }
            column(TOTALCaption_Control1102760059; TOTALCaption_Control1102760059Lbl)
            {
            }
            column(Source__OP_Registers__OTHER___MAIN_Caption; Source__OP_Registers__OTHER___MAIN_CaptionLbl)
            {
            }
            column(Compiled_by_Caption; Compiled_by_CaptionLbl)
            {
            }
            column(Date_Caption; Date_CaptionLbl)
            {
            }
            column(Av__Daily_Attendance_OTHER_Caption; Av__Daily_Attendance_OTHER_CaptionLbl)
            {
            }
            column(Av__Daily_Attendance_MAIN_Caption; Av__Daily_Attendance_MAIN_CaptionLbl)
            {
            }
            column(Av__Daily_Attendance__OTHER___MAIN__Caption; Av__Daily_Attendance__OTHER___MAIN__CaptionLbl)
            {
            }
            column(Integer_Number; Number)
            {
            }

            trigger OnAfterGetRecord()
            begin
                /*Reset the values as required*/
                /*Check if the upper limit has been reached*/
                IF UpperLimit < Number THEN BEGIN EXIT END;
                dtDate := DMY2DATE(Number, IntMonth, Year);

                /*Get the number of staff members in Kasarani*/
                Treatment.RESET;
                //Treatment.SETRANGE(Treatment."Treatment Location",Treatment."Treatment Location"::Nyeri);
                Treatment.SETRANGE(Treatment."Treatment Type", Treatment."Treatment Type"::Outpatient);
                Treatment.SETRANGE(Treatment."Treatment Date", dtDate);
                Treatment.SETRANGE(Treatment."Patient Type", Treatment."Patient Type"::Student);
                Treatment.SETRANGE(Treatment.Status, Treatment.Status::Completed);
                stfMsn := Treatment.COUNT;
                GstfMsn := GstfMsn + stfMsn;

                Treatment.RESET;
                //Treatment.SETRANGE(Treatment."Treatment Location",Treatment."Treatment Location"::Nyeri);
                Treatment.SETRANGE(Treatment."Treatment Type", Treatment."Treatment Type"::Outpatient);
                Treatment.SETRANGE(Treatment."Treatment Date", dtDate);
                Treatment.SETRANGE(Treatment."Patient Type", Treatment."Patient Type"::Employee);
                Treatment.SETRANGE(Treatment.Status, Treatment.Status::Completed);
                dpnMsn := Treatment.COUNT;
                GdpnMsn := GdpnMsn + dpnMsn;

                Treatment.RESET;
                //Treatment.SETRANGE(Treatment."Treatment Location",Treatment."Treatment Location"::Nyeri);
                //Treatment.SETRANGE(Treatment."Treatment Type",Treatment."Treatment Type"::Outpatient);
                Treatment.SETRANGE(Treatment."Treatment Date", dtDate);
                Treatment.SETRANGE(Treatment."Patient Type", Treatment."Patient Type"::Others);
                Treatment.SETRANGE(Treatment.Status, Treatment.Status::Completed);
                stuMsn := Treatment.COUNT;
                GstuMsn := GstuMsn + stuMsn;

                Treatment.RESET;
                //Treatment.SETRANGE(Treatment."Treatment Location",Treatment."Treatment Location"::Nyeri);
                Treatment.SETRANGE(Treatment."Treatment Type", Treatment."Treatment Type"::Outpatient);
                Treatment.SETRANGE(Treatment."Treatment Date", dtDate);
                Treatment.SETRANGE(Treatment."Patient Type", Treatment."Patient Type"::" ");
                Treatment.SETRANGE(Treatment.Status, Treatment.Status::Completed);
                othMsn := Treatment.COUNT;
                GothMsn := GothMsn + othMsn;
                /*
               {Get the details for kisumu}
               Treatment.RESET;
               Treatment.SETRANGE(Treatment."Treatment Location",Treatment."Treatment Location"::"1");
               Treatment.SETRANGE(Treatment."Treatment Type",Treatment."Treatment Type"::Outpatient);
               Treatment.SETRANGE(Treatment."Treatment Date",dtDate);
               Treatment.SETRANGE(Treatment."Patient Type",Treatment."Patient Type"::Employee);
               stfKsm:=Treatment.COUNT;
               GstfKsm :=GstfKsm + stfKsm;

               Treatment.RESET;
               Treatment.SETRANGE(Treatment."Treatment Location",Treatment."Treatment Location"::"1");
               Treatment.SETRANGE(Treatment."Treatment Type",Treatment."Treatment Type"::Outpatient);
               Treatment.SETRANGE(Treatment."Treatment Date",dtDate);
               Treatment.SETRANGE(Treatment."Patient Type",Treatment."Patient Type"::Relative);
               dpnKsm:=Treatment.COUNT;
               GdpnKsm:=GdpnKsm + dpnKsm;

               Treatment.RESET;
               Treatment.SETRANGE(Treatment."Treatment Location",Treatment."Treatment Location"::"1");
               Treatment.SETRANGE(Treatment."Treatment Type",Treatment."Treatment Type"::Outpatient);
               Treatment.SETRANGE(Treatment."Treatment Date",dtDate);
               Treatment.SETRANGE(Treatment."Patient Type",Treatment."Patient Type"::Student);
               stuKsm:=Treatment.COUNT;
               GstuKsm:=GstuKsm + stuKsm;

               Treatment.RESET;
               Treatment.SETRANGE(Treatment."Treatment Location",Treatment."Treatment Location"::"1");
               Treatment.SETRANGE(Treatment."Treatment Type",Treatment."Treatment Type"::Outpatient);
               Treatment.SETRANGE(Treatment."Treatment Date",dtDate);
               Treatment.SETRANGE(Treatment."Patient Type",Treatment."Patient Type"::Others);
               othKsm:=Treatment.COUNT;
               GothKsm:=GothKsm + othKsm;
                */

            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO(Number);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        Year := DATE2DMY(TODAY, 3);
    end;

    trigger OnPreReport()
    begin
        /*Check the month that the user has selected*/
        IF Month = Month::January THEN BEGIN
            IntMonth := 1;
        END
        ELSE
            IF Month = Month::February THEN BEGIN
                IntMonth := 2;
            END
            ELSE
                IF Month = Month::March THEN BEGIN
                    IntMonth := 3;
                END
                ELSE
                    IF Month = Month::April THEN BEGIN
                        IntMonth := 4;
                    END
                    ELSE
                        IF Month = Month::May THEN BEGIN
                            IntMonth := 5;
                        END
                        ELSE
                            IF Month = Month::June THEN BEGIN
                                IntMonth := 6;
                            END
                            ELSE
                                IF Month = Month::July THEN BEGIN
                                    IntMonth := 7;
                                END
                                ELSE
                                    IF Month = Month::August THEN BEGIN
                                        IntMonth := 8;
                                    END
                                    ELSE
                                        IF Month = Month::September THEN BEGIN
                                            IntMonth := 9;
                                        END
                                        ELSE
                                            IF Month = Month::October THEN BEGIN
                                                IntMonth := 10;
                                            END
                                            ELSE
                                                IF Month = Month::November THEN BEGIN
                                                    IntMonth := 11;
                                                END
                                                ELSE
                                                    IF Month = Month::December THEN BEGIN
                                                        IntMonth := 12;
                                                    END;
        /*Determine the upper limit*/
        UpperLimit := HRDates.DetermineDaysInMonth(IntMonth, Year);

    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Month: Option January,February,March,April,May,June,July,August,September,October,November,December;
        IntMonth: Integer;
        Year: Integer;
        UpperLimit: Integer;
        HRDates: Codeunit "Hr Dates";
        dtDate: Date;
        stfMsn: Integer;
        stfKsm: Integer;
        dpnMsn: Integer;
        dpnKsm: Integer;
        stuMsn: Integer;
        stuKsm: Integer;
        othMsn: Integer;
        othKsm: Integer;
        Treatment: Record "HMS-Treatment Form Header";
        GstfMsn: Integer;
        GstfKsm: Integer;
        GdpnMsn: Integer;
        GdpnKsm: Integer;
        GstuMsn: Integer;
        GstuKsm: Integer;
        GothMsn: Integer;
        GothKsm: Integer;
        HEALTH_SERVICESCaptionLbl: Label 'HEALTH SERVICES';
        DATECaptionLbl: Label 'DATE';
        MAINCaptionLbl: Label 'MAIN';
        OTHERCaptionLbl: Label 'OTHER';
        MAINCaption_Control1102760007Lbl: Label 'MAIN';
        OTHERCaption_Control1102760008Lbl: Label 'OTHER';
        MAINCaption_Control1102760009Lbl: Label 'MAIN';
        OTHERCaption_Control1102760010Lbl: Label 'OTHER';
        MAINCaption_Control1102760011Lbl: Label 'MAIN';
        OTHERCaption_Control1102760012Lbl: Label 'OTHER';
        MAINCaption_Control1102760013Lbl: Label 'MAIN';
        MAINCaption_Control1102760014Lbl: Label 'MAIN';
        STAFFCaptionLbl: Label 'STAFF';
        DEPENDANTCaptionLbl: Label 'DEPENDANT';
        STUDENTCaptionLbl: Label 'STUDENT';
        OTHERSCaptionLbl: Label 'OTHERS';
        TOTALCaptionLbl: Label 'TOTAL';
        TOTALCaption_Control1102760059Lbl: Label 'TOTAL';
        Source__OP_Registers__OTHER___MAIN_CaptionLbl: Label 'Source: OP Registers (OTHER + MAIN)';
        Compiled_by_CaptionLbl: Label 'Compiled by:';
        Date_CaptionLbl: Label 'Date:';
        Av__Daily_Attendance_OTHER_CaptionLbl: Label 'Av. Daily Attendance OTHER=';
        Av__Daily_Attendance_MAIN_CaptionLbl: Label 'Av. Daily Attendance MAIN=';
        Av__Daily_Attendance__OTHER___MAIN__CaptionLbl: Label 'Av. Daily Attendance (OTHER + MAIN)=';
}

