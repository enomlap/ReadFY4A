
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
public class myConv{

	static String filePath = "data/FY4A-_AGRI--_N_DISK_1047E_L1-_FDI-_MULT_NOM_20190731000000_20190731001459_4000M_V0001.HDF";
	static float Kelvin = 273.13f;

	public static void main(String[] args) throws Exception {


		double[] storage;
		storage=lc2latlon(1233 ,2324,"4000M");
for (int i = 0; i < storage.length; i++)
            System.out.print(storage[i] + " ");
		System.out.println("---------");
//		System.out.println(a[1]);
//		System.out.println(a[0]);
	}


	/******************************************************************
	 * 
	 * (line, column) → (lat, lon)
	 * resolution：文件名中的分辨率{'0500M', '1000M', '2000M', '4000M'}
	 * 
	 ******************************************************************/
	public static double[] lc2latlon(int line,int column,String resolution) {

		double ea = 6378.137;  //地球的半长轴[km]
		double eb = 6356.7523;  //地球的短半轴[km]
		int h = 42164;  //地心到卫星质心的距离[km]
		double λD = Math.toRadians(104.7);  // 卫星星下点所在经度

		Map<String, Double> COFF = new HashMap<String, Double>();
		COFF.put("0500M",10991.5);
		COFF.put("1000M",5495.5);
		COFF.put("2000M",2747.5);
		COFF.put("4000M",1373.5);
		//列比例因子
		Map<String, Integer> CFAC = new HashMap<String, Integer>();
		CFAC.put("0500M",81865099);
		CFAC.put("1000M",40932549);
		CFAC.put("2000M",20466274);
		CFAC.put("4000M",10233137);	

		// Step1.求x,y
		double xreg = (column-COFF.get(resolution)) / (Math.pow(2,-16)*CFAC.get(resolution));
		double yreg = (line-COFF.get(resolution)) / (Math.pow(2,-16)*CFAC.get(resolution));
		double x = Math.toRadians(xreg);
		double y = Math.toRadians(yreg);

		// Step2.求sd,sn,s1,s2,s3,sxy
		double cosx = Math.cos(x);
		double cosy = Math.cos(y);
		double siny = Math.sin(y);
		double cos2y = Math.pow(cosy, 2);
		double hcosxcosy = h * cosx * cosy;
		double cos2y_ea_eb_sin2y_2 = cos2y + Math.pow((ea/eb*siny), 2);
		double sd = Math.sqrt(Math.pow(hcosxcosy, 2) - cos2y_ea_eb_sin2y_2 * (Math.pow(h, 2)-Math.pow(ea, 2)));
		double sn = (hcosxcosy - sd)/cos2y_ea_eb_sin2y_2;
		double s1 = h - sn * cosx * cosy;
		double s2 = sn * Math.sin(x) * cosy;
		double s3 = -sn * siny;
		double sxy = Math.sqrt(s1*s1+s2*s2);

		// Step3.求lon,lat
		double lon = Math.toDegrees(Math.atan(s2/s1)+λD);
		double lat = Math.toDegrees(Math.atan(Math.pow(ea, 2)/Math.pow(eb, 2)*s3/sxy)); 
		double[] lonlat = {lon,lat};

		return lonlat;
	}
}
