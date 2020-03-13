public class main {

    public static void main(String[] args) {
        String s = "callback( {\"client_id\":\"101859678\",\"openid\":\"61BFF7002A8D3A69E3BDC78B380EFD1C\"} );";

        System.out.println(s);

        System.out.println(s.indexOf('{'));
        System.out.println(s.indexOf('}'));

        String s1 = s.substring(s.indexOf('{'), s.indexOf('}')+1);

        System.out.println(s1);
    }

}
