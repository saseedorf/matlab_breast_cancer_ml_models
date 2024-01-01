%plotting bar graph of people affected with breast cancer(gender-wise comparision)

m=0;
f=0;
for i=1:length(gender);
    if(data1{i,1}==1)
        m=m+1;
    else
        f=f+1;
    end
end

X = categorical({'Female','Male'});
X = reordercats(X,{'Female','Male'});
Y = [f,m];
bar(X,Y);
title("People affected from breast cancer");

m=0;f=0;
%plotting graph of people who died(gender-wise)
for i=1:length(gender)
    if(data1{i,1}==1 && data1{i,25}=="death")
        m=m+1;
     end
    if(data1{i,1}==0 && data1{i,25}=="death")
        f=f+1;
    end
end
X = categorical({'Female','Male'});
X2 = reordercats(X,{'Female','Male'});
Y2 = [f,m];
bar(X2,Y2);
title("Death due to breast cancer");


%%

%recovered
for i=1:length(gender)
    if(data1{i,1}==1 && data1{i,25}=="recovered")
        m=m+1;
    end
    if(data1{i,1}==0 && data1{i,25}=="recovered")
        f=f+1;
    end
end
X = categorical({'Female','Male'});
X3 = reordercats(X,{'Female','Male'});
Y3 = [f,m];
bar(X,Y);
title("recovery cases(gender-wise)");


%%
ys = [Y;Y2;Y3]
xs = categorical({'Affected','Death','Recovered'});
xs = reordercats(xs,{'Affected','Death','Recovered'});
bar(xs,ys);
title('Gender-wise comparison of People with Breast Cancer')
labels = {'Female','Male'};
lgd = legend(labels);
lgd.Layout.Tile = 'north';

%%
%plotting a scatter plot showing relation between menstrual_age, age and
%cancer type
c=[];
for i=1:length(gender)
    if(data1{i,24}==0)
         c(i)='r';
    else
         c(i)='b';
    end
end


%disp(c);
x=table2array(data(:,4));
y=table2array(data(:,23));
scatter(y,x,[],c,'filled')
xlabel("menstrual age");
ylabel("age");
title('Age and Menstrual age on Benign vs Malignant')
legend('Malignant','Benign', 'Location','Best');


%%
%grouped bar plot for relation between blood type and tumour type
apb=0;apm=0;anb=0;anm=0;abpb=0;abpn=0;abnb=0;abnm=0;bnp=0;bnm=0;bpb=0;bpm=0;opb=0;opm=0;onb=0;onm=0;
for i=1:length(gender)
    if(data1{i,13}==0 && data1{i,24}==0)
        apb=apb+1;
    end
    if(data1{i,13}==0 && data1{i,24}==1)
        apm=apm+1;
    end
    if(data1{i,13}==1 && data1{i,24}==0)
        anb=apb+1;
    end
    if(data1{i,13}==1 && data1{i,24}==1)
        anm=apm+1;
    end 
    if(data1{i,13}==2 && data1{i,24}==0)
        abpb=abpb+1;
    end
    if(data1{i,13}==2 && data1{i,24}==1)
        abpm=apm+1;
    end
    if(data1{i,13}==3 && data1{i,24}==0)
        abnb=apb+1;
    end
    if(data1{i,13}==3 && data1{i,24}==1)
        abnm=apm+1;
    end
    if(data1{i,13}==4 && data1{i,24}==0)
        bpb=apb+1;
    end
    if(data1{i,13}==4 && data1{i,24}==1)
        bpm=apm+1;
    end
    if(data1{i,13}==5 && data1{i,24}==0)
        bnb=apb+1;
    end
    if(data1{i,13}==5 && data1{i,24}==1)
        bnm=apm+1;
    end
    if(data1{i,13}==6 && data1{i,24}==0)
        opb=apb+1;
    end
    if(data1{i,13}==6 && data1{i,24}==1)
        opm=apm+1;
    end
    if(data1{i,13}==7 && data1{i,24}==0)
        onb=apb+1;
    end
    if(data1{i,13}==7 && data1{i,24}==1)
        onm=apm+1;
    end
end

ap=[apb,apm];
an=[anb,anm];
abp=[abpb,abpm];
abn=[abnb,abnm];
bp=[bpb,bpm];
bn=[bnb,bnm];
op=[opb,opm];
on=[onb,onm];
y=[ap;an;abp;abn;bp;bn;op;on];
X = categorical({'A+','A-','AB+','AB-','B+','B-','O+','O-'});
X = reordercats(X,{'A+','A-','AB+','AB-','B+','B-','O+','O-'});
bar(X,y);
title('Relation between blood type and tumour type');
labels = {'benign','malignant'};
lgd = legend(labels);

%%
% Model	Accuracy	Precision	Recall	F1 Score
% KNN	0.9981	0.9951	1.0000	0.9975
% SVM	0.6220	0.6220	1.0000	0.7669
% DA	0.6219	0.6219	1.0000	0.7669
% DT	0.6219	0.6220	1.0000	0.7669

Model	Accuracy
	Train	Test
KNN	0.9981	0.9981
SVM	0.6220	0.4737
DA	0.6219	0.4736
DT	0.6219	0.4736

Train_Acc = [0.9981 0.6220 0.6219 0.6219]
Test_Acc = [0.9981 0.4737 0.4736 0.4736]
%%
Knn=[0.9981	0.9951	1.0000	0.9975]
Svm=[0.6220	0.6220	1.0000	0.7669]
Da=[0.6219	0.6219	1.0000	0.7669]
Dt=[0.6219	0.6220	1.0000	0.7669]

yaxis = [Knn;Svm;Da;Dt]


%%
Acc=[0.9981	0.6220	0.6219	0.6219]
Pre=[0.9951	0.6220	0.6219	0.6220]
Rec=[1.0000	1.0000	1.0000	1.0000]
F1=[0.9975	0.7669	0.7669	0.7669]

yaxis = [Acc;Pre;Rec;F1]

xaxis = categorical({'Accuracy','Precision','Recall','F1'});
xaxis = reordercats(xaxis,{'Accuracy','Precision','Recall','F1'});

bar(xaxis,yaxis)
title('Results of Prediction on Machine Learning Models');
labels = {'KNN','SVM','DA','DT'};
lgd = legend(labels);

%%

Train_Acc = [0.9981 0.6220 0.6219 0.6219]
Test_Acc = [0.9981 0.4737 0.4736 0.4736]
y_acc = [Train_Acc; Test_Acc]
x_acc = categorical({'Train','Test'});
x_acc = reordercats(x_acc,{'Train','Test'});
bar(x_acc,y_acc)
title('Ablation Study on Accuracy of Train vs Test');
labels = {'KNN','SVM','DA','DT'};
lgd = legend(labels);
