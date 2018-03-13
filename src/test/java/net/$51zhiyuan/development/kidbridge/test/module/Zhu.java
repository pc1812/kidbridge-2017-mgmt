package net.$51zhiyuan.development.kidbridge.test.module;

import org.apache.commons.lang3.RandomUtils;
import org.apache.commons.lang3.StringUtils;
import org.junit.Test;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class Zhu {

    private final Random random = new Random();

    @Test
    public void zhijia(){
        //int upper = 5;
        //int under = 4;
//        int limit = 9;
//        int quantity = 2;
//        int[] problem = new int[quantity];
//        for(int i=0;i<problem.length;i++){
////            if(i == 0){
////                problem[i] = RandomUtils.nextInt(1,8+1);
////                limit -= problem[i];
////            }
////            if(i == 1){
////                problem[i] = RandomUtils.nextInt(1,limit+1);
////                if(limit - problem[i] < 5){
////                    problem[i] = 5;
////                }
////            }
//            problem[i] = RandomUtils.nextInt(1,limit);
//            limit -= problem[i];
//        }
//
//
//        for(int number : problem){
//            System.out.println(number);
//        }




        int limit = 9;
        int quantity = 2;
        int[] problem = new int[quantity];
        for(int i=0;i<problem.length;i++){
            problem[i] = RandomUtils.nextInt(1,9);
            limit -= problem[i];
        }


        for(int number : problem){
            System.out.println(number);
        }
    }

    public int random(){
        return this.random.nextInt(9) + 1;
    }

    @Test
    public void test(){
        System.out.println(RandomUtils.nextInt(1,2));
    }
}
