/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.gpms.controller;
import com.gpms.pojo.BirthdayJob;
import com.gpms.pojo.DashboardModel;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import static org.quartz.JobBuilder.newJob;
import static org.quartz.TriggerBuilder.newTrigger;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.quartz.CronScheduleBuilder;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.Trigger;
import org.quartz.impl.StdSchedulerFactory;

public class QuartzListener implements ServletContextListener {
        Scheduler scheduler = null;
        String res="";

        @Override
        public void contextInitialized(ServletContextEvent servletContext) {
            res="Context Initialized";
                System.out.println(res);
                
                try {
                    if(res.equals("Context Initialized")){
                 
                        // Setup the Job class and the Job group
                        JobDetail job = newJob(BirthdayJob.class).withIdentity(
                                        "CronQuartzJob", "Group").build();

                        // Create a Trigger that fires every 5 minutes.
                        Trigger trigger = newTrigger()
                        .withIdentity("TriggerName", "Group")
                        .withSchedule(CronScheduleBuilder.cronSchedule("0/60 * * * * ?"))
                        .build();

                        // Setup the Job and Trigger with Scheduler & schedule jobs
                        scheduler = new StdSchedulerFactory().getScheduler();
                        scheduler.start();
                        scheduler.scheduleJob(job, trigger);
                        
                       
                    }
                }
                catch (SchedulerException e) {
                        e.printStackTrace();
                } 
        }

        @Override
        public void contextDestroyed(ServletContextEvent servletContext) {
                System.out.println("Context Destroyed");
                try 
                {
                        scheduler.shutdown();
                } 
                catch (SchedulerException e) 
                {
                        e.printStackTrace();
                }
        }

}
