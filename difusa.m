function m=difusa(m)
  if size(m)==[1,1]
    m=m;
  elseif min(size(m))>1
    m(1:end-1,:)=m(1:end-1,:)+m(2:end,:);
    m(2:end,:)=m(2:end,:)+m(1:end-1,:);
    m(:,1:end-1)=m(:,1:end-1)+m(:,2:end);
    m(:,2:end)=m(:,2:end)+m(:,1:end-1);
  end
end
